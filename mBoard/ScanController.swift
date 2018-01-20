//
//  ScanController.swift
//  mBoard
//
//  Created by hu on 4/18/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import AVFoundation
import UIKit

import Alamofire

class ScanController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var session:AVCaptureSession?
    var preview:AVCaptureVideoPreviewLayer?
    var qr:UIView?
    var servers = [String]()
    
    let defaults = UserDefaults.standard
    
    // MARK: Properties
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cancelBtn.layer.borderColor = UIColor.white.cgColor
        cancelBtn.layer.borderWidth = 1
        cancelBtn.layer.cornerRadius = 5
    
        qr = UIView()
        qr?.layer.borderColor = UIColor.green.cgColor
        qr?.layer.borderWidth = 2
        //qr?.frame = self.view.layer.bounds
        
        let device = AVCaptureDevice.default(
            for: AVMediaType.video)
        
        var input: AVCaptureDeviceInput
        
        do {
            
            input = try AVCaptureDeviceInput(device: device!)
            
            session = AVCaptureSession()
            
            session?.addInput(input)
        
            let output = AVCaptureMetadataOutput()
            
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            session?.addOutput(output)
            
            output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            preview = AVCaptureVideoPreviewLayer(session: session!)
            
            preview?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            preview?.frame = self.view.layer.bounds
            //preview?.frame = CGRect(x: self.view.layer.bounds.width/2,
            //                        y: self.view.layer.bounds.height/2 ,
            //                        width: 200, height: 200)
            self.view.layer.addSublayer(preview!)
            
            session?.startRunning()
            
            output.rectOfInterest = (preview?.metadataOutputRectConverted(
                fromLayerRect: (preview?.bounds)!))!
            
        } catch {
            print(error)
            return
        }
        
        self.view.bringSubview(toFront: address)
        self.view.bringSubview(toFront: cancelBtn)
        self.view.bringSubview(toFront: qr!)
        self.view.addSubview(qr!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects == nil || metadataObjects.count == 0 {
            address.text = "No QR code found"
        }
        
        let obj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
        
        if obj?.type == AVMetadataObject.ObjectType.qr {
            
            let code = preview?.transformedMetadataObject(for: obj!) as! AVMetadataMachineReadableCodeObject
            
            qr?.frame = code.bounds
            
            if obj?.stringValue != nil {
                
                defaults.set(obj!.stringValue, forKey: Mboard.SERVER)
                
                let saved = defaults.array(forKey: Mboard.SAVED_SERVERS) as? [String]
                
                var save = true
                
                if saved != nil {
                
                    for s in saved! {
                        
                        if s == obj!.stringValue {
                            save = false
                        }
                        
                    }
                    
                    if save {
                        
                        servers.append(obj!.stringValue!)
                        
                        defaults.set(servers, forKey: Mboard.SAVED_SERVERS)
                        
                    }
                    
                } else {
                    
                    servers.append(obj!.stringValue!)
                    
                    defaults.set(servers, forKey: Mboard.SAVED_SERVERS)
                    
                }
                
                
                session?.stopRunning()
                
                //preview?.removeFromSuperlayer()
                
                preview = nil
                session = nil
                
                // TODO: test if connection is good
                self.getVersion()
                
                
                
            }
            
        }
        
    }
    
    func getVersion() {
        
        let ed = defaults.object(forKey: Mboard.SERVER) as? String
        
        let url = "\(Mboard.HTTP)\(ed!)/api/games"
        
        Alamofire.request(url, method: .get)
            .response{ response in
                
                if response.error != nil {
                    
                    let ac = UIAlertController(title: "Connection error",
                                               message: response.error?.localizedDescription,
                                               preferredStyle: UIAlertControllerStyle.alert)
                    
                    let OK = UIAlertAction(title: "OK",
                                           style: UIAlertActionStyle.default,
                                           handler: nil)
                    
                    ac.addAction(OK)
                    
                    self.present(ac, animated: true, completion: nil)
                    
                    
                    
                } else {
                    self.performSegue(withIdentifier: "connectedSegue",
                                      sender: self)
                }
                
        }
        
    } // getVersion
    

    // MARK: Actions
    
} // ScanController
