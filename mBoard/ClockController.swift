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
    var errorCount = 0
    
    var server:String?
    var running = false
    
    
    let defaults = UserDefaults.standard
    let verbosePeriods = ["1st", "2nd", "3rd", "4th"]
    
    // MARK: Properties
    @IBOutlet weak var nextPeriodBtn: UIButton!
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
    @IBOutlet weak var awayPos: UIButton!
    @IBOutlet weak var homePos: UIButton!
    @IBOutlet weak var posLabel: UILabel!
    @IBOutlet weak var shotclockStack: UIStackView!
    
    override func viewDidDisappear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        server = (defaults.object(forKey: Mboard.SERVER) as? String)!
        
        clockPause()
        
        posLabel.layer.masksToBounds = true
        posLabel.layer.cornerRadius = 5
        
        nextPeriodBtn.layer.cornerRadius = 5
        nextPeriodBtn.layer.borderColor = UIColor.red.cgColor
        nextPeriodBtn.layer.borderWidth = 1
        nextPeriodBtn.isEnabled = false
        
        
        resetGCBtn.setFAIcon(icon: FAType.FARefresh, iconSize: 16, forState: .normal)
        
        rewBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        fwdBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        
        rewSCBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        fwdSCBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        
        resetSCBtn.setFAIcon(icon: FAType.FARefresh, iconSize: 16, forState: .normal)
        
        //startBtn.setFATitleColor(color: Mboard.NeonGreenColor)
        
        startBtn.layer.borderColor = Mboard.NeonGreenColor.cgColor
        startBtn.layer.borderWidth = 1
        startBtn.layer.cornerRadius = startBtn.bounds.size.width/2
        
        startBtn.layer.masksToBounds = true

        
        rewBtn.layer.borderColor = Mboard.TealColor.cgColor
        rewBtn.layer.borderWidth = 1
        rewBtn.layer.cornerRadius = rewBtn.bounds.size.width/2
        rewBtn.layer.masksToBounds = true
        
        fwdBtn.layer.borderColor = Mboard.TealColor.cgColor
        fwdBtn.layer.borderWidth = 1
        fwdBtn.layer.cornerRadius = fwdBtn.bounds.size.width/2
        fwdBtn.layer.masksToBounds = true
        
        rewSCBtn.layer.borderColor = Mboard.TealColor.cgColor
        rewSCBtn.layer.borderWidth = 1
        rewSCBtn.layer.cornerRadius = rewSCBtn.bounds.size.width/2
        rewSCBtn.layer.masksToBounds = true
        
        fwdSCBtn.layer.borderColor = Mboard.TealColor.cgColor
        fwdSCBtn.layer.borderWidth = 1
        fwdSCBtn.layer.cornerRadius = fwdSCBtn.bounds.size.width/2
        fwdSCBtn.layer.masksToBounds = true
        
        resetGCBtn.layer.borderColor = UIColor.red.cgColor
        resetGCBtn.layer.borderWidth = 1
        resetGCBtn.layer.cornerRadius = fwdBtn.bounds.size.width/2
        resetGCBtn.layer.masksToBounds = true

        
        resetSCBtn.layer.borderColor = UIColor.red.cgColor
        resetSCBtn.layer.borderWidth = 1
        resetSCBtn.layer.cornerRadius = fwdBtn.bounds.size.width/2
        resetSCBtn.layer.masksToBounds = true

        awayPos.layer.borderColor = Mboard.TealColor.cgColor
        awayPos.layer.borderWidth = 1
        awayPos.layer.cornerRadius = 5

        homePos.layer.borderColor = Mboard.TealColor.cgColor
        homePos.layer.borderWidth = 1
        homePos.layer.cornerRadius = 5
        
        
        
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
                nextPeriodBtn.isEnabled = true
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
                self.shotclockStack.isHidden = true
            } else {
                self.shotClock.isHidden = false
                self.shotclockStack.isHidden = false
            }
            
        } else {
            vio = j["shotclock"].int!
        }
        
        let sc = vio - j["shot"]["seconds"].int!
        
        self.shotClock.text = "\(sc)"
        
    } // setShotClock
    
    
    func clockPause() {
        
        running = false
        
        startBtn.setFAIcon(icon: FAType.FAPlay, iconSize: 48, forState: .normal)
        
    } // clockPause

    func clockUnpause() {
        
        running = true
        
        startBtn.setFAIcon(icon: FAType.FAPause, iconSize: 48, forState: .normal)
        
    } // clockPause
    
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
                        
                        self.awayPos.setTitle(j["away"]["name"].string!, for: .normal)
                        self.homePos.setTitle(j["home"]["name"].string!, for: .normal)
                        
                        self.initWS()
                        
                    }
                    
                }
                
        }
        
    } // loadGame
    
    
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
                    
                    
                case "SHOT_VIOLATION":
                    
                    self.clockPause()
                    
                    
                    
                    // play sound on server side
                    
                    
                case "END_PERIOD":
                    
                    self.nextPeriodBtn.isEnabled = true
                    self.clockPause()
                    
                    
                case "PERIOD":
                    
                    let p = obj["val"].string!
                    
                    self.period.text = self.verbosePeriods[Int(p)!]
                    
                    
                case "POSSESSION_HOME":

                    //self.homePos.layer.borderColor = UIColor.green.cgColor
                    //self.awayPos.layer.borderColor = Mboard.TealColor.cgColor
                    self.homePos.layer.backgroundColor = Mboard.TealColor.cgColor
                    self.awayPos.layer.backgroundColor = UIColor.clear.cgColor
                    
                    //self.homePos.setTitleColor(UIColor.white, for: .normal)
                    
                    //self.awayPos.setTitleColor(Mboard.TealColor, for: .normal)
                    
                    
                case "POSSESSION_AWAY":
                    
                    self.homePos.layer.backgroundColor = UIColor.clear.cgColor
                    self.awayPos.layer.backgroundColor = Mboard.TealColor.cgColor
                    
                    //self.awayPos.setTitleColor(UIColor.white, for: .normal)
                    
                    //self.homePos.setTitleColor(Mboard.TealColor, for: .normal)
                    
                    
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
            ]))
        
        clockPause()
        
    }
    
    @IBAction func gcAddTick(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_CLOCK_STEP,
            "step": 1
            ]))

        clockPause()
        
    }
    
    @IBAction func gcReset(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_CLOCK_RESET
            ]))
        
        clockPause()
        
    }
    
    @IBAction func scMinusTick(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_SHOT_STEP,
            "step": -1
            ]))
        
        clockPause()
        
    }
    
    @IBAction func scAddTick(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_SHOT_STEP,
            "step": 1
            ]))
        
        clockPause()
        
    }
    
    @IBAction func scReset(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_SHOT_RESET
            ]))
        
        clockPause()
        
    }
    
    @IBAction func toggleClock(_ sender: Any) {
        
        if running {
            
            ws.send(JSON([
                "cmd": Mboard.WS_CLOCK_STOP
                ]))
            
            clockPause()
            
        } else {
            
            ws.send(JSON([
                "cmd": Mboard.WS_CLOCK_START
                ]))
            
            clockUnpause()
            
        }
        
    }
    
    @IBAction func changePeriod(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_PERIOD_UP
            ]))
        
        nextPeriodBtn.isEnabled = false
        
    }
    
    @IBAction func awayPosChange(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_POSSESSION_AWAY,
            "meta": ["stop": !running]
        ]))
        
        
        
    }
    
    @IBAction func homePosChange(_ sender: Any) {

        ws.send(JSON([
            "cmd": Mboard.WS_POSSESSION_HOME,
            "meta": ["stop": !running]
            ]))
        
    }
    
    
    
    
} // ClockController
