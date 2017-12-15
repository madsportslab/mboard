//
//  AdjustClock.swift
//  mBoard
//
//  Created by hu on 11/5/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Alamofire
import Font_Awesome_Swift
import SwiftWebSocket
import SwiftyJSON

class AdjustClock: UIViewController {

    var ws = WebSocket()
    var server:String?
    
    let defaults = UserDefaults.standard
    
    // MARK: Properties
    @IBOutlet weak var gameClock: UILabel!
    @IBOutlet weak var shotClock: UILabel!
    @IBOutlet weak var incrGameBtn: UIButton!
    @IBOutlet weak var decrGameBtn: UIButton!
    @IBOutlet weak var resetGameBtn: UIButton!
    @IBOutlet weak var incrShotBtn: UIButton!
    @IBOutlet weak var decrShotBtn: UIButton!
    @IBOutlet weak var resetShotBtn: UIButton!
    
    

    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        server = (defaults.object(forKey: Mboard.SERVER) as? String)!
        
        incrGameBtn.setFAIcon(icon: FAType.FAStepBackward, iconSize: 32, forState: .normal)
        decrGameBtn.setFAIcon(icon: FAType.FAStepForward, iconSize: 32, forState: .normal)
        resetGameBtn.setFAIcon(icon: FAType.FARefresh, iconSize: 32, forState: .normal)
        
        incrShotBtn.setFAIcon(icon: FAType.FAStepBackward, iconSize: 32, forState: .normal)
        decrShotBtn.setFAIcon(icon: FAType.FAStepForward, iconSize: 32, forState: .normal)
        resetShotBtn.setFAIcon(icon: FAType.FARefresh, iconSize: 32, forState: .normal)
        
        incrGameBtn.layer.borderWidth = 1
        incrGameBtn.layer.backgroundColor = UIColor.clear.cgColor
        incrGameBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        decrGameBtn.layer.borderWidth = 1
        decrGameBtn.layer.backgroundColor = UIColor.clear.cgColor
        decrGameBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        resetGameBtn.layer.borderWidth = 1
        resetGameBtn.layer.backgroundColor = UIColor.clear.cgColor
        resetGameBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        incrShotBtn.layer.borderWidth = 1
        incrShotBtn.layer.backgroundColor = UIColor.clear.cgColor
        incrShotBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        decrShotBtn.layer.borderWidth = 1
        decrShotBtn.layer.backgroundColor = UIColor.clear.cgColor
        decrShotBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        resetShotBtn.layer.borderWidth = 1
        resetShotBtn.layer.backgroundColor = UIColor.clear.cgColor
        resetShotBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        loadGame()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "clockSegue" {
            
            if let tab = segue.destination as? UITabBarController {
                tab.selectedIndex = 1
            }
            
        }
    }
    
    func loadGame() {
        
        let url = "\(Mboard.HTTP)\(server!)/api/games"
        
        Alamofire.request(url, method: .get)
            .responseJSON{ response in
                
                switch response.result {
                case .failure(let error):
                    
                    if let status = response.response?.statusCode {
                        
                        if status == 404 {
                            
                            let ac = UIAlertController(title: "Connection error",
                                                       message: "No game initialized",
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
                        
                        self.setGameClock(j)
                        self.setShotClock(j)
                        
                        self.initWS()
                        
                    }
                    
                }
                
        }
        
    } // loadGame
    
    func setGameClock(_ j: JSON) {
        
        var mins = 0
        
        if j["settings"].exists() {
            mins = j["settings"]["minutes"].int!
        } else {
            mins = j["minutes"].int!
        }
        
        let delta = mins * 60 - j["game"]["seconds"].int!
        let ndelta = delta - 1
        let seconds = delta % 60
        let minutes = Int(floor(Double(delta)/60.0))
        let tenths = 10 - j["game"]["tenths"].int!
        
        
        if delta == 60 {
            
            if minutes == 1 {
                
                if tenths == 10 {
                    gameClock.text = "\(minutes):00"
                } else {
                    gameClock.text = "\(ndelta).\(tenths)"
                }
                
            } else {
                gameClock.text = "\(minutes):59.\(tenths)"
            }
            
        } else if minutes == 0 {
            
            if ndelta == -1 {
                gameClock.text = "0.0"
            } else if tenths == 10 {
                gameClock.text = "\(delta).0"
            } else {
                gameClock.text = "\(ndelta).\(tenths)"
            }
            
        } else if seconds == 0 {
            gameClock.text = "\(minutes):00"
        } else if seconds < 10 && seconds >= 0 {
            gameClock.text = "\(minutes):0\(seconds)"
        } else {
            gameClock.text = "\(minutes):\(seconds)"
        }
        
    } // setGameClock
    
    func setShotClock(_ j: JSON) {
        
        var vio = 0
        
        if j["settings"].exists() {
            vio = j["settings"]["shot"].int!
            
            if vio == -1 {
            
                self.shotClock.isHidden = true
                self.incrShotBtn.isHidden = true
                self.decrShotBtn.isHidden = true
                self.resetShotBtn.isHidden = true

            } else {
                
                self.shotClock.isHidden = false
                self.incrShotBtn.isHidden = false
                self.decrShotBtn.isHidden = false
                self.resetShotBtn.isHidden = false

            }
            
        } else {
            vio = j["shotclock"].int!
        }
        
        let sc = vio - j["shot"]["seconds"].int!
        
        self.shotClock.text = "\(sc)"
        
    } // setShotClock
    
    func initWS() {
        
        //ws = WebSocket(Mboard.GAMESOCKET)
        
        let url = "\(Mboard.WS)\(server!)/ws/game"
        
        ws = WebSocket(url)
        
        ws.event.close = { code, reason, clean in
            
            self.ws.open()
            
        }
        
        ws.event.open = {
            print("socket connected")
        }
        
        ws.event.error = { error in
            print(error)
        }
        
        ws.event.message = { message in
            
            if let txt = message as? String {
                
                var obj = JSON.parse(txt)
                
                print(obj)
                
                switch obj["key"] {
                case "CLOCK":
                    
                    let v = JSON.parse(obj["val"].string!)
                    
                    self.setGameClock(v)
                    self.setShotClock(v)
                    
                default:
                    print("Unknown message from websocket.")
                    
                }
                
            }
        }
        
    } // initWS
    
    // MARK: Actions
    
    @IBAction func gameClockDown(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_CLOCK_STEP,
            "step": 1
            ]))
        
    }
    
    @IBAction func gameClockUp(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_CLOCK_STEP,
            "step": -1
            ]))
        
    }
    
    @IBAction func resetGameClock(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_CLOCK_RESET
            ]))
        
    }
    
    @IBAction func shotClockDown(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_SHOT_STEP,
            "step": 1
            ]))
        
    }
    
    @IBAction func shotClockUp(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_SHOT_STEP,
            "step": -1
            ]))
        
    }
    
    @IBAction func shotClockReset(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_SHOT_RESET
            ]))
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "clockSegue", sender: self)
    }
    
} // AdjustClock

