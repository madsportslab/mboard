//
//  ClockController.swift
//  mBoard
//
//  Created by hu on 4/12/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import AVKit

import Alamofire
import Font_Awesome_Swift
import SwiftWebSocket
import SwiftyJSON

class ClockController: UIViewController {

    var ws = WebSocket()
    
    var running = false
    
    
    // MARK: Properties
    @IBOutlet weak var gameClock: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var shotClock: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var rewBtn: UIButton!
    @IBOutlet weak var fwdBtn: UIButton!
    @IBOutlet weak var rewSCBtn: UIButton!
    @IBOutlet weak var fwdSCBtn: UIButton!
    @IBOutlet weak var resetGCBtn: UIButton!
    @IBOutlet weak var resetSCBtn: UIButton!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var shotLabel: UILabel!
    
    override func viewDidDisappear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        
        startBtn.setFAIcon(icon: FAType.FAPlay, iconSize: 96, forState: .normal)
        
        resetGCBtn.setFAIcon(icon: FAType.FARefresh, iconSize: 24, forState: .normal)
        
        rewBtn.setFAIcon(icon: FAType.FABackward, iconSize: 24, forState: .normal)
        fwdBtn.setFAIcon(icon: FAType.FAForward, iconSize: 24, forState: .normal)
        
        rewSCBtn.setFAIcon(icon: FAType.FABackward, iconSize: 24, forState: .normal)
        fwdSCBtn.setFAIcon(icon: FAType.FAForward, iconSize: 24, forState: .normal)
        
        resetSCBtn.setFAIcon(icon: FAType.FARefresh, iconSize: 24, forState: .normal)
        
        
        startBtn.setFATitleColor(color: Mboard.NeonGreenColor)
        
        startBtn.layer.borderColor = Mboard.NeonGreenColor.cgColor
        startBtn.layer.borderWidth = 1
        startBtn.layer.cornerRadius = 5
        
        rewBtn.layer.borderColor = Mboard.TealColor.cgColor
        rewBtn.layer.borderWidth = 1
        rewBtn.layer.cornerRadius = 5
        
        fwdBtn.layer.borderColor = Mboard.TealColor.cgColor
        fwdBtn.layer.borderWidth = 1
        fwdBtn.layer.cornerRadius = 5
        
        rewSCBtn.layer.borderColor = Mboard.TealColor.cgColor
        rewSCBtn.layer.borderWidth = 1
        rewSCBtn.layer.cornerRadius = 5
        
        fwdSCBtn.layer.borderColor = Mboard.TealColor.cgColor
        fwdSCBtn.layer.borderWidth = 1
        fwdSCBtn.layer.cornerRadius = 5
        
        resetGCBtn.layer.borderColor = UIColor.red.cgColor
        resetGCBtn.layer.borderWidth = 1
        resetGCBtn.layer.cornerRadius = 5
        
        resetSCBtn.layer.borderColor = UIColor.red.cgColor
        resetSCBtn.layer.borderWidth = 1
        resetSCBtn.layer.cornerRadius = 5
        
        loadGame()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
                gameClock.text = "\(ndelta).0"
            } else {
                gameClock.text = "\(ndelta).\(tenths)"
            }
            
        } else if seconds < 10 {
            gameClock.text = "\(minutes):0\(ndelta)"
        } else {
            gameClock.text = "\(minutes):\(ndelta)"
        }
        
    } // setGameClock
    
    func setShotClock(_ j: JSON) {
        
        var vio = 0
        
        if j["settings"].exists() {
            vio = j["settings"]["shot"].int!
        } else {
            vio = j["shotclock"].int!
        }
        
        let sc = vio - j["shot"]["seconds"].int!
        
        self.shotClock.text = "\(sc)"
        
    } // setShotClock
    
    
    func loadGame() {
        
        
        Alamofire.request(Mboard.GAMES, method: .get)
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
                        
                        self.setGameClock(j)
                        self.setShotClock(j)
                        
                        self.initWS()
                        
                    }
                    
                }
                
        }
        
    } // loadGame
    
    
    func initWS() {
        
        ws = WebSocket(Mboard.GAMESOCKET)
        
        ws.event.close = { code, reason, clean in
            print("close")
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
                    
                    var v = JSON.parse(obj["val"].string!)
                    
                    self.setGameClock(v)
                    self.setShotClock(v)
                    
                    
                case "PERIOD":
                    print("TODO")
                default:
                    print("Unknown message from websocket.")
                }
                
            }
        }
        
    } // initWS
    
    
    // MARK: Actions
    @IBAction func gcMinusTick(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_CLOCK_STEP,
            "step": -1
            ]));
        
        running = false
        
        startBtn.setFAIcon(icon: FAType.FAPlay, iconSize: 96, forState: .normal)
        
    }
    
    @IBAction func gcAddTick(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_CLOCK_STEP,
            "step": 1
            ]));

        running = false
        
        startBtn.setFAIcon(icon: FAType.FAPlay, iconSize: 96, forState: .normal)
        
    }
    
    @IBAction func gcReset(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_CLOCK_RESET
            ]));
        
        running = false
        
        startBtn.setFAIcon(icon: FAType.FAPlay, iconSize: 96, forState: .normal)
        
    }
    
    @IBAction func scMinusTick(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_SHOT_STEP,
            "step": -1
            ]));
        
        running = false
        
        startBtn.setFAIcon(icon: FAType.FAPlay, iconSize: 96, forState: .normal)
        
    }
    
    @IBAction func scAddTick(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_SHOT_STEP,
            "step": 1
            ]));
        
        running = false
        
        startBtn.setFAIcon(icon: FAType.FAPlay, iconSize: 96, forState: .normal)
        
    }
    
    @IBAction func scReset(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_SHOT_RESET
            ]));
        
        running = false
        
        startBtn.setFAIcon(icon: FAType.FAPlay, iconSize: 96, forState: .normal)
        
    }
    
    @IBAction func toggleClock(_ sender: Any) {
        
        if running {
            
            ws.send(JSON([
                "cmd": Mboard.WS_CLOCK_STOP
                ]));
            
            running = false
            
            startBtn.setFAIcon(icon: FAType.FAPlay, iconSize: 96, forState: .normal)
            
        } else {
            
            ws.send(JSON([
                "cmd": Mboard.WS_CLOCK_START
                ]));
            
            running = true
            
            startBtn.setFAIcon(icon: FAType.FAPause, iconSize: 96, forState: .normal)
            
        }
        
    }
    
    
} // ClockController