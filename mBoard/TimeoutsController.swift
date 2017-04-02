//
//  TimeoutsController.swift
//  mBoard
//
//  Created by hu on 4/1/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Font_Awesome_Swift

class TimeoutsController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    // MARK: Properties
    @IBOutlet weak var t3: UIButton!
    @IBOutlet weak var t4: UIButton!
    @IBOutlet weak var t5: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        t3.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                     size: 14, forState: .normal)
        
        t4.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                     size: 14, forState: .normal)
        
        t5.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                     size: 14, forState: .normal)
        
        loadDefaultSettings()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDefaultSettings() {
        
        let dtimeouts = defaults.integer(forKey: Mboard.TIMEOUTS)
        
        if dtimeouts == 0 {
            
            defaults.set(3, forKey: Mboard.TIMEOUTS)
            
            t3.setFATitleColor(color: UIColor.black)
            t4.setFATitleColor(color: UIColor.clear)
            t5.setFATitleColor(color: UIColor.clear)
            
        } else {
            
            if dtimeouts == 4 {
                
                t3.setFATitleColor(color: UIColor.clear)
                t4.setFATitleColor(color: UIColor.black)
                t5.setFATitleColor(color: UIColor.clear)
                
            } else if dtimeouts == 5 {
                
                t3.setFATitleColor(color: UIColor.clear)
                t4.setFATitleColor(color: UIColor.clear)
                t5.setFATitleColor(color: UIColor.black)
                
            } else {
                
                t3.setFATitleColor(color: UIColor.black)
                t4.setFATitleColor(color: UIColor.clear)
                t5.setFATitleColor(color: UIColor.clear)
                
            }
            
        }

    } // loadDefaultSettings

    // MARK: Actions
    
    @IBAction func changeT3(_ sender: Any) {
        
        t3.setFATitleColor(color: UIColor.black)
        t4.setFATitleColor(color: UIColor.clear)
        t5.setFATitleColor(color: UIColor.clear)
        
        defaults.set(3, forKey: Mboard.TIMEOUTS)
        
    }
    
    @IBAction func changeT4(_ sender: Any) {
        
        t3.setFATitleColor(color: UIColor.clear)
        t4.setFATitleColor(color: UIColor.black)
        t5.setFATitleColor(color: UIColor.clear)
        
        defaults.set(4, forKey: Mboard.TIMEOUTS)
        
    }
    
    @IBAction func changeT5(_ sender: Any) {
        
        t3.setFATitleColor(color: UIColor.clear)
        t4.setFATitleColor(color: UIColor.clear)
        t5.setFATitleColor(color: UIColor.black)
        
        defaults.set(5, forKey: Mboard.TIMEOUTS)
        
    }
    
    
    
} // TimeoutsController
