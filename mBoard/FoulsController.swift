//
//  FoulsController.swift
//  mBoard
//
//  Created by hu on 4/1/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Font_Awesome_Swift

class FoulsController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    // MARK: Properties
    @IBOutlet weak var f0: UIButton!
    @IBOutlet weak var f5: UIButton!
    @IBOutlet weak var f8: UIButton!
    @IBOutlet weak var f10: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        f0.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                     size: 14, forState: .normal)
        
        f5.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                     size: 14, forState: .normal)
        
        f8.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                     size: 14, forState: .normal)
        
        f10.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                     size: 14, forState: .normal)
        
        loadDefaultSettings()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDefaultSettings() {
    
        let dfouls = defaults.integer(forKey: Mboard.FOULS)
        
        if dfouls == 0 {
            
            defaults.set(0, forKey: Mboard.FOULS)
            
            f0.setFATitleColor(color: UIColor.black)
            f5.setFATitleColor(color: UIColor.clear)
            f8.setFATitleColor(color: UIColor.clear)
            f10.setFATitleColor(color: UIColor.clear)
            
        } else if dfouls == 5 {
                
            f0.setFATitleColor(color: UIColor.clear)
            f5.setFATitleColor(color: UIColor.black)
            f8.setFATitleColor(color: UIColor.clear)
            f10.setFATitleColor(color: UIColor.clear)
                
        } else if dfouls == 8 {
            
            f0.setFATitleColor(color: UIColor.clear)
            f5.setFATitleColor(color: UIColor.clear)
            f8.setFATitleColor(color: UIColor.black)
            f10.setFATitleColor(color: UIColor.clear)
                
        } else {
                
            f0.setFATitleColor(color: UIColor.clear)
            f5.setFATitleColor(color: UIColor.clear)
            f8.setFATitleColor(color: UIColor.clear)
            f10.setFATitleColor(color: UIColor.black)
                
        }
        
    }
    
    // MARK: Actions
    @IBAction func changeF0(_ sender: Any) {
        
        f0.setFATitleColor(color: UIColor.black)
        f5.setFATitleColor(color: UIColor.clear)
        f8.setFATitleColor(color: UIColor.clear)
        f10.setFATitleColor(color: UIColor.clear)
        
        defaults.set(0, forKey: Mboard.FOULS)
        
    }
    
    @IBAction func changeF5(_ sender: Any) {
        
        f0.setFATitleColor(color: UIColor.clear)
        f5.setFATitleColor(color: UIColor.black)
        f8.setFATitleColor(color: UIColor.clear)
        f10.setFATitleColor(color: UIColor.clear)
        
        defaults.set(5, forKey: Mboard.FOULS)
        
    }
    
    @IBAction func changeF8(_ sender: Any) {
        
        f0.setFATitleColor(color: UIColor.clear)
        f5.setFATitleColor(color: UIColor.clear)
        f8.setFATitleColor(color: UIColor.black)
        f10.setFATitleColor(color: UIColor.clear)
        
        defaults.set(8, forKey: Mboard.FOULS)
        
    }
    
    @IBAction func changeF10(_ sender: Any) {
        
        f0.setFATitleColor(color: UIColor.clear)
        f5.setFATitleColor(color: UIColor.clear)
        f8.setFATitleColor(color: UIColor.clear)
        f10.setFATitleColor(color: UIColor.black)
        
        defaults.set(10, forKey: Mboard.FOULS)
        
    }
    
    
} // FoulsController
