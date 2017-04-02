//
//  MinutesController.swift
//  mBoard
//
//  Created by hu on 4/1/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Font_Awesome_Swift

class MinutesController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    // MARK: Properties
    @IBOutlet weak var m5: UIButton!
    @IBOutlet weak var m8: UIButton!
    @IBOutlet weak var m10: UIButton!
    @IBOutlet weak var m12: UIButton!
    @IBOutlet weak var m15: UIButton!
    @IBOutlet weak var m20: UIButton!
    @IBOutlet weak var m30: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        m5.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                      size: 14, forState: .normal)
        
        m8.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                      size: 14, forState: .normal)
        
        m10.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                      size: 14, forState: .normal)
        
        m12.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                      size: 14, forState: .normal)
        
        m15.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                      size: 14, forState: .normal)
        
        m20.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                      size: 14, forState: .normal)
        
        m30.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                      size: 14, forState: .normal)
        
        loadDefaultSettings()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadDefaultSettings() {
    
        let dminutes = defaults.integer(forKey: Mboard.MINUTES)
    
        if dminutes == 8 {
            
            m5.setFATitleColor(color: UIColor.clear)
            m8.setFATitleColor(color: UIColor.black)
            m10.setFATitleColor(color: UIColor.clear)
            m12.setFATitleColor(color: UIColor.clear)
            m15.setFATitleColor(color: UIColor.clear)
            m20.setFATitleColor(color: UIColor.clear)
            m30.setFATitleColor(color: UIColor.clear)
            
        } else if dminutes == 10 {
            
            m5.setFATitleColor(color: UIColor.clear)
            m8.setFATitleColor(color: UIColor.clear)
            m10.setFATitleColor(color: UIColor.black)
            m12.setFATitleColor(color: UIColor.clear)
            m15.setFATitleColor(color: UIColor.clear)
            m20.setFATitleColor(color: UIColor.clear)
            m30.setFATitleColor(color: UIColor.clear)
            
        } else if dminutes == 12 {
            
            m5.setFATitleColor(color: UIColor.clear)
            m8.setFATitleColor(color: UIColor.clear)
            m10.setFATitleColor(color: UIColor.clear)
            m12.setFATitleColor(color: UIColor.black)
            m15.setFATitleColor(color: UIColor.clear)
            m20.setFATitleColor(color: UIColor.clear)
            m30.setFATitleColor(color: UIColor.clear)
            
        } else if dminutes == 15 {
            
            m5.setFATitleColor(color: UIColor.clear)
            m8.setFATitleColor(color: UIColor.clear)
            m10.setFATitleColor(color: UIColor.clear)
            m12.setFATitleColor(color: UIColor.clear)
            m15.setFATitleColor(color: UIColor.black)
            m20.setFATitleColor(color: UIColor.clear)
            m30.setFATitleColor(color: UIColor.clear)
            
        } else if dminutes == 20 {
            
            m5.setFATitleColor(color: UIColor.clear)
            m8.setFATitleColor(color: UIColor.clear)
            m10.setFATitleColor(color: UIColor.clear)
            m12.setFATitleColor(color: UIColor.clear)
            m15.setFATitleColor(color: UIColor.clear)
            m20.setFATitleColor(color: UIColor.black)
            m30.setFATitleColor(color: UIColor.clear)
            
        } else if dminutes == 30 {
            
            m5.setFATitleColor(color: UIColor.clear)
            m8.setFATitleColor(color: UIColor.clear)
            m10.setFATitleColor(color: UIColor.clear)
            m12.setFATitleColor(color: UIColor.clear)
            m15.setFATitleColor(color: UIColor.clear)
            m20.setFATitleColor(color: UIColor.clear)
            m30.setFATitleColor(color: UIColor.black)
            
        } else {
            
            defaults.set(5, forKey: Mboard.MINUTES)
            
            m5.setFATitleColor(color: UIColor.black)
            m8.setFATitleColor(color: UIColor.clear)
            m10.setFATitleColor(color: UIColor.clear)
            m12.setFATitleColor(color: UIColor.clear)
            m15.setFATitleColor(color: UIColor.clear)
            m20.setFATitleColor(color: UIColor.clear)
            m30.setFATitleColor(color: UIColor.clear)
            
        }
        
    }
    
    // MARK: Actions
    
    @IBAction func changeM5(_ sender: Any) {
        
        defaults.set(5, forKey: Mboard.MINUTES)
        
        m5.setFATitleColor(color: UIColor.black)
        m8.setFATitleColor(color: UIColor.clear)
        m10.setFATitleColor(color: UIColor.clear)
        m12.setFATitleColor(color: UIColor.clear)
        m15.setFATitleColor(color: UIColor.clear)
        m20.setFATitleColor(color: UIColor.clear)
        m30.setFATitleColor(color: UIColor.clear)
        
    }
    
    @IBAction func changeM8(_ sender: Any) {
    
        defaults.set(8, forKey: Mboard.MINUTES)
        
        m5.setFATitleColor(color: UIColor.clear)
        m8.setFATitleColor(color: UIColor.black)
        m10.setFATitleColor(color: UIColor.clear)
        m12.setFATitleColor(color: UIColor.clear)
        m15.setFATitleColor(color: UIColor.clear)
        m20.setFATitleColor(color: UIColor.clear)
        m30.setFATitleColor(color: UIColor.clear)
        
    }
    
    @IBAction func changeM10(_ sender: Any) {
    
        defaults.set(10, forKey: Mboard.MINUTES)
        
        m5.setFATitleColor(color: UIColor.clear)
        m8.setFATitleColor(color: UIColor.clear)
        m10.setFATitleColor(color: UIColor.black)
        m12.setFATitleColor(color: UIColor.clear)
        m15.setFATitleColor(color: UIColor.clear)
        m20.setFATitleColor(color: UIColor.clear)
        m30.setFATitleColor(color: UIColor.clear)
        
    }
    
    @IBAction func changeM12(_ sender: Any) {
    
        defaults.set(12, forKey: Mboard.MINUTES)
        
        m5.setFATitleColor(color: UIColor.clear)
        m8.setFATitleColor(color: UIColor.clear)
        m10.setFATitleColor(color: UIColor.clear)
        m12.setFATitleColor(color: UIColor.black)
        m15.setFATitleColor(color: UIColor.clear)
        m20.setFATitleColor(color: UIColor.clear)
        m30.setFATitleColor(color: UIColor.clear)
        
    }
    
    @IBAction func changeM15(_ sender: Any) {
    
        defaults.set(15, forKey: Mboard.MINUTES)
        
        m5.setFATitleColor(color: UIColor.clear)
        m8.setFATitleColor(color: UIColor.clear)
        m10.setFATitleColor(color: UIColor.clear)
        m12.setFATitleColor(color: UIColor.clear)
        m15.setFATitleColor(color: UIColor.black)
        m20.setFATitleColor(color: UIColor.clear)
        m30.setFATitleColor(color: UIColor.clear)
        
    }
    
    @IBAction func changeM20(_ sender: Any) {
    
        defaults.set(20, forKey: Mboard.MINUTES)
        
        m5.setFATitleColor(color: UIColor.clear)
        m8.setFATitleColor(color: UIColor.clear)
        m10.setFATitleColor(color: UIColor.clear)
        m12.setFATitleColor(color: UIColor.clear)
        m15.setFATitleColor(color: UIColor.clear)
        m20.setFATitleColor(color: UIColor.black)
        m30.setFATitleColor(color: UIColor.clear)
        
    }
    
    @IBAction func changeM30(_ sender: Any) {
    
        defaults.set(30, forKey: Mboard.MINUTES)
        
        m5.setFATitleColor(color: UIColor.clear)
        m8.setFATitleColor(color: UIColor.clear)
        m10.setFATitleColor(color: UIColor.clear)
        m12.setFATitleColor(color: UIColor.clear)
        m15.setFATitleColor(color: UIColor.clear)
        m20.setFATitleColor(color: UIColor.clear)
        m30.setFATitleColor(color: UIColor.black)
        
    }
    
    
} // MinutesController
