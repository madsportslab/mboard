//
//  GameSettingController.swift
//  mBoard
//
//  Created by hu on 3/31/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Alamofire
import Font_Awesome_Swift

class GameSettingController: UIViewController, UITextFieldDelegate {
    
    let defaults = UserDefaults.standard
    
    // MARK: Properties
    @IBOutlet weak var homeName: UITextField!
    @IBOutlet weak var awayName: UITextField!
    @IBOutlet weak var periods: UIButton!
    @IBOutlet weak var minutes: UIButton!
    @IBOutlet weak var shotclock: UIButton!
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
        
        loadDefaultSettings()
        
        periods.setFATitleColor(color: UIColor.black)
        minutes.setFATitleColor(color: UIColor.black)
        fouls.setFATitleColor(color: UIColor.black)
        timeouts.setFATitleColor(color: UIColor.black)
        shotclock.setFATitleColor(color: UIColor.black)
        
        homeName.delegate = self
        awayName.delegate = self
        
        homeName.becomeFirstResponder()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        
        if textField == homeName {
            
            defaults.set(textField.text!, forKey: Mboard.HOMENAME)
            
            awayName.becomeFirstResponder()
            
        } else {
            
            defaults.set(textField.text!, forKey: Mboard.AWAYNAME)
            homeName.becomeFirstResponder()
            
        }

        return true
        
    }
    
    func loadDefaultSettings() {
    
        let dperiods     = defaults.integer(forKey: Mboard.PERIODS)
        let dminutes     = defaults.integer(forKey: Mboard.MINUTES)
        let dshotclock   = defaults.integer(forKey: Mboard.SHOTCLOCK)
        let dfouls       = defaults.integer(forKey: Mboard.FOULS)
        let dtimeouts    = defaults.integer(forKey: Mboard.TIMEOUTS)
        
        
        if let an = defaults.object(forKey: Mboard.AWAYNAME) as? String {
            awayName.text = an
        }
        
        if let hn = defaults.object(forKey: Mboard.HOMENAME) as? String {
            homeName.text = hn
        }
        
        if dperiods == 0 {
            
            defaults.set(4, forKey: Mboard.PERIODS)
            
            periods.setFAText(prefixText: "4\t", icon: FAType.FAAngleRight,
                postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
        
        } else {
        
            let str0 = String(dperiods) + "\t"
            
            periods.setFAText(prefixText: str0, icon: FAType.FAAngleRight,
                              postfixText: "\t", size: 14, forState: .normal,
                              iconSize: 16)
            
        }
        
        if dminutes == 0 {
            
            defaults.set(12, forKey: Mboard.MINUTES)
            
            minutes.setFAText(prefixText: "12\t", icon: FAType.FAAngleRight,
                              postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
            
        } else {

            let str1 = String(dminutes) + "\t"

            minutes.setFAText(prefixText: str1, icon: FAType.FAAngleRight,
                              postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
            
        }
        
        
        if dshotclock == 0 {
            
            defaults.set(0, forKey: Mboard.SHOTCLOCK)
            
            shotclock.setFAText(prefixText: "0\t", icon: FAType.FAAngleRight,
                              postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
            
        } else {
            
            let str1 = String(dshotclock) + "\t"
            
            shotclock.setFAText(prefixText: str1, icon: FAType.FAAngleRight,
                              postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
            
        }
        
        if dfouls == 0 {
            
            defaults.set(0, forKey: Mboard.FOULS)
            
            fouls.setFAText(prefixText: "0\t", icon: FAType.FAAngleRight,
                            postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
            
        } else {

            let str2 = String(dfouls) + "\t"
            
            fouls.setFAText(prefixText: str2, icon: FAType.FAAngleRight,
                            postfixText: "\t", size: 14, forState: .normal, iconSize: 16)

        }
        
        if dtimeouts == 0 {
            
            defaults.set(3, forKey: Mboard.TIMEOUTS)
            
            timeouts.setFAText(prefixText: "3\t", icon: FAType.FAAngleRight,
                               postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
        
        } else {
        
            let str3 = String(dtimeouts) + "\t"

            timeouts.setFAText(prefixText: str3, icon: FAType.FAAngleRight,
                               postfixText: "\t", size: 14, forState: .normal, iconSize: 16)
        }
        
        
        
    } // loadDefaultSettings
    
    
    func collectSettings() -> [String: String] {
    
        let p    = defaults.integer(forKey: Mboard.PERIODS)
        let m    = defaults.integer(forKey: Mboard.MINUTES)
        let s    = defaults.integer(forKey: Mboard.SHOTCLOCK)
        let f    = defaults.integer(forKey: Mboard.FOULS)
        let t    = defaults.integer(forKey: Mboard.TIMEOUTS)
        
        return [
          "home": homeName.text!, "away": awayName.text!, "periods": String(p),
          "minutes": String(m), "shot": String(s),
          "fouls": String(f), "timeouts": String(t)]
        
    } // collectSettings
    
    
    func createGame() {
        
        let ed = defaults.object(forKey: Mboard.SERVER) as? String
        
        let url = "\(Mboard.HTTP)\(ed!)/api/games"
        
        let params = collectSettings()
        
        Alamofire.request(url, method: .post, parameters: params)
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
                    
                    self.defaults.removeObject(forKey: Mboard.AWAYNAME)
                    self.defaults.removeObject(forKey: Mboard.HOMENAME)
                    
                    self.performSegue(withIdentifier: "gameSegue", sender: self)
                }
                
        }
        
    } // createGame

    func saveTeams() {
        
        defaults.set(homeName.text!, forKey: Mboard.HOMENAME)
        defaults.set(awayName.text!, forKey: Mboard.AWAYNAME)
        
    } // saveTeams
    
    // MARK: Actions
    @IBAction func startGame(_ sender: Any) {
        
        if (homeName.text?.isEmpty)! || (awayName.text?.isEmpty)! {
            
            let ac = UIAlertController(title: "Setup error",
                                       message: "Team names cannot be empty.",
                                       preferredStyle: UIAlertControllerStyle.alert)
            
            let OK = UIAlertAction(title: "OK",
                                   style: UIAlertActionStyle.default,
                                   handler: nil)
            
            ac.addAction(OK)
            
            self.present(ac, animated: true, completion: nil)
            
        } else {
            createGame()
        }
        
    
    } // startGame
    
    @IBAction func changePeriods(_ sender: Any) {
        saveTeams()
        self.performSegue(withIdentifier: "periodsSegue", sender: self)
    } // changePeriods
    
    @IBAction func changeMinutes(_ sender: Any) {
        saveTeams()
        self.performSegue(withIdentifier: "minutesSegue", sender: self)
    }
    
    @IBAction func changeShotclock(_ sender: Any) {
        saveTeams()
        self.performSegue(withIdentifier: "shotclockSegue", sender: self)
    }
    
    @IBAction func changeFouls(_ sender: Any) {
        saveTeams()
        self.performSegue(withIdentifier: "foulsSegue", sender: self)
    }
    
    @IBAction func changeTimeouts(_ sender: Any) {
        saveTeams()
        self.performSegue(withIdentifier: "timeoutsSegue", sender: self)
    }
    
    
} // GameSettingController
