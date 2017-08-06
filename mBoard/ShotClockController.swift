//
//  ShotClockController.swift
//  mBoard
//
//  Created by hu on 4/10/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Font_Awesome_Swift

class ShotClockController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    // MARK: Properties
    @IBOutlet weak var s0: UIButton!
    @IBOutlet weak var s24: UIButton!
    @IBOutlet weak var s30: UIButton!
    @IBOutlet weak var s35: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        s0.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                      size: 14, forState: .normal)
        
        s24.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                     size: 14, forState: .normal)
        
        s30.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                     size: 14, forState: .normal)
        
        s35.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                     size: 14, forState: .normal)
        
        loadDefaultSettings()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDefaultSettings() {
        
        let dshotclock = defaults.integer(forKey: Mboard.SHOTCLOCK)
        
        if dshotclock == 0 {
            
            s0.setFATitleColor(color: UIColor.black)
            s24.setFATitleColor(color: UIColor.clear)
            s30.setFATitleColor(color: UIColor.clear)
            s35.setFATitleColor(color: UIColor.clear)
            
        } else if dshotclock == 24 {
            
            s0.setFATitleColor(color: UIColor.clear)
            s24.setFATitleColor(color: UIColor.black)
            s30.setFATitleColor(color: UIColor.clear)
            s35.setFATitleColor(color: UIColor.clear)
            
        } else if dshotclock == 30 {
            
            defaults.set(30, forKey: Mboard.SHOTCLOCK)
            
            s0.setFATitleColor(color: UIColor.clear)
            s24.setFATitleColor(color: UIColor.clear)
            s30.setFATitleColor(color: UIColor.black)
            s35.setFATitleColor(color: UIColor.clear)
            
        } else if dshotclock == 35 {
            
            s0.setFATitleColor(color: UIColor.clear)
            s24.setFATitleColor(color: UIColor.clear)
            s30.setFATitleColor(color: UIColor.clear)
            s35.setFATitleColor(color: UIColor.black)
            
        }
        
    }
    
    // MARK: Actions
    
    @IBAction func changeS0(_ sender: Any) {
        
        s0.setFATitleColor(color: UIColor.black)
        s24.setFATitleColor(color: UIColor.clear)
        s30.setFATitleColor(color: UIColor.clear)
        s35.setFATitleColor(color: UIColor.clear)
        
        defaults.set(0, forKey: Mboard.SHOTCLOCK)
        
    }
    
    @IBAction func changeS24(_ sender: Any) {
        
        s0.setFATitleColor(color: UIColor.clear)
        s24.setFATitleColor(color: UIColor.black)
        s30.setFATitleColor(color: UIColor.clear)
        s35.setFATitleColor(color: UIColor.clear)
        
        defaults.set(24, forKey: Mboard.SHOTCLOCK)
        
    }
    
    @IBAction func changeS30(_ sender: Any) {
        
        s24.setFATitleColor(color: UIColor.clear)
        s24.setFATitleColor(color: UIColor.clear)
        s30.setFATitleColor(color: UIColor.black)
        s35.setFATitleColor(color: UIColor.clear)
        
        defaults.set(30, forKey: Mboard.SHOTCLOCK)
        
    }
    
    @IBAction func changeS35(_ sender: Any) {
        
        s0.setFATitleColor(color: UIColor.clear)
        s24.setFATitleColor(color: UIColor.clear)
        s30.setFATitleColor(color: UIColor.clear)
        s35.setFATitleColor(color: UIColor.black)
        
        defaults.set(35, forKey: Mboard.SHOTCLOCK)
        
    }
    
    
} // ShotClockController
