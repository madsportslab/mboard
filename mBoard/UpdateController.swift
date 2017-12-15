//
//  UpdateController.swift
//  mBoard
//
//  Created by hu on 11/18/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

class UpdateController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    var server:String?
    
    // MARK: Properties
    @IBOutlet weak var currentLbl: UILabel!
    @IBOutlet weak var latestLbl: UILabel!
    @IBOutlet weak var updateBtn: UIBarButtonItem!
    @IBOutlet weak var progress: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //aboutLabel.text = "Take your sporting events to the next level with mboard, the digital scoreboard.  mboard brings a modern, digital experience to sports providing real time data, rich media, in-game analyses, and much more.  Created by madsportslab whose mission is to bring the best experiences for all sports.  We are sports enthusiasts and technology experts, welcome to the next generation of sports."
        
        server = (defaults.object(forKey: Mboard.SERVER) as? String)!
        
        self.progress.isHidden = true
        
        getFirmware()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "aboutSegue" {
            
            if let tab = segue.destination as? UITabBarController {
                tab.selectedIndex = 4
            }
            
        }
    }
    
    func getFirmware() {
        
        let url = "\(Mboard.HTTP)\(server!)/api/version"
        
        Alamofire.request(url, method: .get)
            .responseJSON{ response in
                
                switch response.result {
                case .failure(let error):
                    
                    if let status = response.response?.statusCode {
                        
                        if status == 404 {
                            
                            let ac = UIAlertController(title: "Connection error",
                                                       message: "Unable to retrieve version",
                                                       preferredStyle: UIAlertControllerStyle.alert)
                            
                            let OK = UIAlertAction(title: "OK",
                                                   style: UIAlertActionStyle.default,
                                                   handler: nil)
                            
                            ac.addAction(OK)
                            
                            self.present(ac, animated: true, completion: nil)
                            
                        } else {
                            
                            let ac = UIAlertController(title: "Connection error",
                                                       message: error.localizedDescription,
                                                       preferredStyle: UIAlertControllerStyle.alert)
                            
                            let OK = UIAlertAction(title: "OK",
                                                   style: UIAlertActionStyle.default,
                                                   handler: nil)
                            
                            ac.addAction(OK)
                            
                            self.present(ac, animated: true, completion: nil)
                            
                        }
                    }
                    
                case .success:
                    
                    print(response.result)
                    
                    if let raw = response.result.value {
                        
                        let j = JSON(raw)
                        
                        print(j)
                        
                        self.currentLbl.text = j["version"].string!
                        
                        self.getUpdateFirmwareVersion(
                            current: self.currentLbl.text!)
                        
                    }
                    
                }
                
        }
        
    } // getFirmware
    
    func getUpdateFirmwareVersion(current:String) {
        
        if current == "" {
            return
        }
        
        let url = "\(Mboard.MADSPORTSLAB)/api/upgrades/mboard/\(current)"
        
        Alamofire.request(url, method: .get)
            .responseJSON{ response in
                
                switch response.result {
                case .failure(let error):
                    
                    self.updateBtn.isEnabled = false
                    
                    if let status = response.response?.statusCode {
                        
                        if status == 404 {
                            
                            
                            let ac = UIAlertController(title: "Update Firmware",
                                                       message: "No updates available.",
                                                       preferredStyle: UIAlertControllerStyle.alert)
                            
                            let OK = UIAlertAction(title: "OK",
                                                   style: UIAlertActionStyle.default,
                                                   handler: nil)
                            
                            ac.addAction(OK)
                            
                            self.present(ac, animated: true, completion: nil)
                            
                        } else {
                            
                            let ac = UIAlertController(title: "Connection error",
                                                       message: error.localizedDescription,
                                                       preferredStyle: UIAlertControllerStyle.alert)
                            
                            let OK = UIAlertAction(title: "OK",
                                                   style: UIAlertActionStyle.default,
                                                   handler: nil)
                            
                            ac.addAction(OK)
                            
                            self.present(ac, animated: true, completion: nil)
                            
                        }
                    }
                    
                case .success:
                    
                    if let raw = response.result.value {
                        
                        let j = JSON(raw)
                        
                        self.latestLbl.text = j["version"].string!
                        
                    }
                    
                }
                
        }
        
    } // getUpdateFirmwareVersion
    
    // MARK: Actions
    
    @IBAction func updateMboard(_ sender: Any) {
        
        let url = "\(Mboard.UPDATESERVICE)/api/update"
        
        print(url)
        Alamofire.request(url, method: .post)
            .response{ response in
                
                if response.error != nil {
                    
                    let ac = UIAlertController(title: "Update error",
                                               message: response.error?.localizedDescription,
                                               preferredStyle: UIAlertControllerStyle.alert)
                    
                    let OK = UIAlertAction(title: "OK",
                                           style: UIAlertActionStyle.default,
                                           handler: nil)
                    
                    ac.addAction(OK)
                    
                    self.present(ac, animated: true, completion: nil)
                    
                } else {

                    let ac = UIAlertController(title: "Update",
                                               message: "Completed",
                                               preferredStyle: UIAlertControllerStyle.alert)
                    
                    let OK = UIAlertAction(title: "OK",
                                           style: UIAlertActionStyle.default,
                                           handler: nil)
                    
                    ac.addAction(OK)
                    
                    self.present(ac, animated: true, completion: nil)
                    
                    self.updateBtn.isEnabled = false
                    
                    self.getFirmware()
                    //self.getUpdateFirmwareVersion(current: <#T##String#>)
                    
                    self.latestLbl.text = "-"

                }
        }
        
    } // updateMboard
    
    @IBAction func goBack(_ sender: Any) {
        self.performSegue(withIdentifier: "aboutSegue", sender: self)
    }
    
    
}
