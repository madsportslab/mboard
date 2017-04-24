//
//  MainViewController.swift
//  mBoard
//
//  Created by hu on 3/31/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Alamofire
import Font_Awesome_Swift

class MainViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    // MARK: Properties
    @IBOutlet weak var scanQR: UIButton!
    @IBOutlet weak var status: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getVersion()
        
        scanQR.setFAIcon(icon: FAType.FACamera, iconSize: 128, forState: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVersion() {
        
        let ed = defaults.object(forKey: Mboard.SERVER) as? String
        
        let url = "\(Mboard.HTTP)\(ed!)/api/version"
        
        Alamofire.request(url, method: .get)
            .response{ response in
                
                if response.error != nil {
                    print(response.error)
                } else {
                    self.performSegue(withIdentifier: "skipScanSegue",
                                      sender: self)
                }
                
        }
        
    } // getVersion
    
    // MARK: Actions
    
} // MainViewController
