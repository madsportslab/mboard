//
//  ScanController.swift
//  mBoard
//
//  Created by hu on 4/18/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import AVFoundation
import UIKit

class ScanController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var session:AVCaptureSession?
    var preview:AVCaptureVideoPreviewLayer?
    var qr:UIView?
    
    let defaults = UserDefaults.standard
    
    // MARK: Properties
    @IBOutlet weak var address: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let device = AVCaptureDevice.defaultDevice(
            withMediaType: AVMediaTypeVideo)
        
        var input: AVCaptureDeviceInput
        
        do {
            
            input = try AVCaptureDeviceInput(device: device)
            
            session = AVCaptureSession()
            
            session?.addInput(input)
        
            let output = AVCaptureMetadataOutput()
            
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            session?.addOutput(output)
            
            output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]

            
            preview = AVCaptureVideoPreviewLayer(session: session)
            
            preview?.videoGravity = AVLayerVideoGravityResizeAspectFill
            preview?.frame = self.view.layer.bounds
            
            self.view.layer.addSublayer(preview!)
            
            qr = UIView()
            qr?.layer.borderColor = UIColor.green.cgColor
            qr?.layer.borderWidth = 2
            
            self.view.addSubview(qr!)
            
            self.view.bringSubview(toFront: address)
            self.view.bringSubview(toFront: qr!)
            
            session?.startRunning()
            
            
            
        } catch {
            print(error)
            return
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if metadataObjects == nil || metadataObjects.count == 0 {
            address.text = "No QR code found"
        }
        
        let obj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
        
        if obj?.type == AVMetadataObjectTypeQRCode {
            
            let code = preview?.transformedMetadataObject(for: obj) as! AVMetadataMachineReadableCodeObject
            
            qr?.frame = code.bounds
            
            if obj?.stringValue != nil {
                
                defaults.set(obj!.stringValue, forKey: Mboard.SERVER)
                
                //address.text = obj!.stringValue
                
                session?.stopRunning()
                //preview?.removeFromSuperlayer()
                preview = nil
                session = nil
                
                self.performSegue(withIdentifier: "connectedSegue",
                                  sender: self)
                
            }
            
        }
        
    }

    // MARK: Actions
    
} // ScanController
