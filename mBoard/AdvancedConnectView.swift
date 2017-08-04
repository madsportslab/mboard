//
//  AdvancedConnectView.swift
//  mBoard
//
//  Created by hu on 7/3/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

class AdvancedConnectView: UIViewController {
    
    let defaults = UserDefaults.standard
    
    // MARK: Properties
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var address: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
        address.becomeFirstResponder()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // MARK: Actions
    @IBAction func connect(_ sender: Any) {
                
        if address.text!.isEmpty {
            
            let ac = UIAlertController(title: "Address error",
                                       message: "Address must be a valid DNS/IP address and cannot be empty.",
                                       preferredStyle: UIAlertControllerStyle.alert)
            
            let OK = UIAlertAction(title: "OK",
                                   style: UIAlertActionStyle.default,
                                   handler: nil)
            
            ac.addAction(OK)
            
            self.present(ac, animated: true, completion: nil)
            
        } else {
            
            defaults.set(address.text, forKey: Mboard.SERVER)
            
            var servers = defaults.array(forKey: Mboard.SAVED_SERVERS) as? [String]
            
            var save = true
            
            if servers != nil {

                for s in servers! {
                    
                    if s == address.text! {
                        save = false
                    }
                    
                }
                
                if save {
                    
                    servers?.append(address.text!)
                    
                    defaults.set(servers, forKey: Mboard.SAVED_SERVERS)
                    
                }

            } else {
                
                var newServers = [String]()
                
                newServers.append(address.text!)
                
                defaults.set(newServers, forKey: Mboard.SAVED_SERVERS)
                
            }
            
            self.performSegue(withIdentifier: "addedSegue",
                              sender: self)
            
        }
        
        
    }
    
} // AdvancedConnectView
