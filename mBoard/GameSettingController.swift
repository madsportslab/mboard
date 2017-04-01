//
//  GameSettingController.swift
//  mBoard
//
//  Created by hu on 3/31/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Font_Awesome_Swift

class GameSettingController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    // MARK: Properties
    @IBOutlet weak var homeName: UITextField!
    @IBOutlet weak var awayName: UITextField!
    @IBOutlet weak var periods: UIButton!
    @IBOutlet weak var minutes: UIButton!
    @IBOutlet weak var fouls: UIButton!
    @IBOutlet weak var timeouts: UIButton!
    @IBOutlet weak var startGameBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startGameBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
          blue: 186/255, alpha: 1).cgColor
        
        startGameBtn.layer.borderWidth = 1
        startGameBtn.layer.cornerRadius = CGFloat(5)
        
        cancelBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                                 blue: 186/255, alpha: 1).cgColor
        
        cancelBtn.layer.borderWidth = 1
        cancelBtn.layer.cornerRadius = CGFloat(5)
        
        /*periods.setFAText(prefixText: "4\t", icon: FAType.FAAngleRight,
            postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
        minutes.setFAText(prefixText: "12\t", icon: FAType.FAAngleRight,
                          postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
        fouls.setFAText(prefixText: "0\t", icon: FAType.FAAngleRight,
                          postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
        timeouts.setFAText(prefixText: "3\t", icon: FAType.FAAngleRight,
                          postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
        
 */
        
        loadDefaultSettings()
        
        periods.setFATitleColor(color: UIColor.black)
        minutes.setFATitleColor(color: UIColor.black)
        fouls.setFATitleColor(color: UIColor.black)
        timeouts.setFATitleColor(color: UIColor.black)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDefaultSettings() {
    
        let dperiods     = defaults.integer(forKey: "mboard.periods")
        let dminutes     = defaults.integer(forKey: "mboard.minutes")
        let dfouls       = defaults.integer(forKey: "mboard.fouls")
        let dtimeouts    = defaults.integer(forKey: "mboard.timeouts")
        
        if dperiods == 0 {
            periods.setFAText(prefixText: "4\t", icon: FAType.FAAngleRight,
                postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
        } else {
            periods.setFAText(prefixText: "2\t", icon: FAType.FAAngleRight,
                              postfixText: "\t", size: 14, forState: .normal,
                              iconSize: 16)
        }
        
        let str1 = String(dminutes) + "\t"
        
        if dminutes == 0 {
            minutes.setFAText(prefixText: "4\t", icon: FAType.FAAngleRight,
                              postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
        } else {
            minutes.setFAText(prefixText: str1, icon: FAType.FAAngleRight,
                              postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
        }
        
        let str2 = String(dfouls) + "\t"
        
        fouls.setFAText(prefixText: str2, icon: FAType.FAAngleRight,
                              postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
        
        let str3 = String(dtimeouts) + "\t"
        print(str3)
        
        if dtimeouts == 0 {
            timeouts.setFAText(prefixText: "3\t", icon: FAType.FAAngleRight,
                               postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
        } else {
            timeouts.setFAText(prefixText: str3, icon: FAType.FAAngleRight,
                               postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
        }
        
        
        
    } // loadDefaultSettings
    
    
    // MARK: Actions
    @IBAction func startGame(_ sender: Any) {
    } // startGame
    
    @IBAction func changePeriods(_ sender: Any) {
        self.performSegue(withIdentifier: "periodsSegue", sender: self)
    } // changePeriods
    
    @IBAction func changeMinutes(_ sender: Any) {
        self.performSegue(withIdentifier: "minutesSegue", sender: self)
    }
    
    @IBAction func changeFouls(_ sender: Any) {
        self.performSegue(withIdentifier: "foulsSegue", sender: self)
    }
    
    @IBAction func changeTimeouts(_ sender: Any) {
        self.performSegue(withIdentifier: "timeoutsSegue", sender: self)
    }
    
    
} // GameSettingController
