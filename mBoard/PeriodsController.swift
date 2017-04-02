//
//  PeriodsController.swift
//  mBoard
//
//  Created by hu on 4/1/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Font_Awesome_Swift

class PeriodsController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    // MARK: Properties
    @IBOutlet weak var p2: UIButton!
    @IBOutlet weak var p4: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        p2.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                     size: 14, forState: .normal)
        
        p4.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                     size: 14, forState: .normal)
        
        loadDefaultSettings()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadDefaultSettings() {
    
        let dperiods = defaults.integer(forKey: Mboard.PERIODS)
        
        if dperiods == 2 {
            
            p2.setFATitleColor(color: UIColor.black)
            p4.setFATitleColor(color: UIColor.clear)
            
        } else {
            
            defaults.set(4, forKey: Mboard.PERIODS)
            
            p2.setFATitleColor(color: UIColor.clear)
            p4.setFATitleColor(color: UIColor.black)
            
        }
        
    }
    
    // MARK: Actions
    
    @IBAction func changeP2(_ sender: Any) {
        
        defaults.set(2, forKey: Mboard.PERIODS)
        
        p2.setFATitleColor(color: UIColor.black)
        p4.setFATitleColor(color: UIColor.clear)
        
    }
    
    @IBAction func changeP4(_ sender: Any) {
    
        defaults.set(4, forKey: Mboard.PERIODS)
        
        p2.setFATitleColor(color: UIColor.clear)
        p4.setFATitleColor(color: UIColor.black)
        
    }
    
    
} // PeriodsController
