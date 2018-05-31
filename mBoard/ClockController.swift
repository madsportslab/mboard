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

    var wsControl       = WebSocket()
    var wsSubscribe     = WebSocket()
    
    var errorCount = 0
    
    var server:String?
    var running = false
    var home:String?
    var away:String?
    
    let defaults = UserDefaults.standard
    
    // MARK: Properties
    //@IBOutlet weak var nextPeriodBtn: UIButton!
    @IBOutlet weak var gameClock: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var shotClock: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var awayTimeout: UIButton!
    @IBOutlet weak var homeTimeout: UIButton!
    @IBOutlet weak var homeTimeoutCancel: UIButton!
    @IBOutlet weak var awayTimeoutCancel: UIButton!
    @IBOutlet weak var awayName: UILabel!
    @IBOutlet weak var homeName: UILabel!
    @IBOutlet weak var awayTimeoutCount: UILabel!
    @IBOutlet weak var homeTimeoutCount: UILabel!
    @IBOutlet weak var ballPos: UISegmentedControl!
    @IBOutlet weak var clockAdjust: UIBarButtonItem!
    @IBOutlet weak var endPeriod: UIBarButtonItem!
    
    
    override func viewDidDisappear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        server = (defaults.object(forKey: Mboard.SERVER) as? String)!
        
        clockPause()
        
        startBtn.layer.borderColor = Mboard.TealColor.cgColor
        startBtn.layer.borderWidth = 1
        startBtn.layer.cornerRadius = 5
 
        awayTimeout.layer.borderWidth = 1
        awayTimeout.layer.cornerRadius = 5

        awayTimeoutCancel.layer.borderWidth = 1
        awayTimeoutCancel.layer.cornerRadius = 5

        homeTimeout.layer.borderWidth = 1
        homeTimeout.layer.cornerRadius = 5

        homeTimeoutCancel.layer.borderWidth = 1
        homeTimeoutCancel.layer.cornerRadius = 5
        
        clockAdjust.setFAIcon(icon: FAType.FASliders, iconSize: 24)
        
        
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
                //nextPeriodBtn.isEnabled = true
                endPeriod.isEnabled = true
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
            } else {
                self.shotClock.isHidden = false
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
        //startBtn.setTitleColor(Mboard., for: .normal)
        startBtn.setFATitleColor(color: Mboard.DarkBlueColor)
        
    } // clockPause

    func clockUnpause() {
        
        running = true
        
        startBtn.setFAIcon(icon: FAType.FAPause, iconSize: 48, forState: .normal)
        //startBtn.setTitleColor(UIColor.clear, for: .normal)
        startBtn.setFATitleColor(color: Mboard.DarkBlueColor)
        
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
                        
                        self.away = j["away"]["name"].string!
                        self.home = j["home"]["name"].string!
                        
                        self.awayName.text = self.away!
                        self.homeName.text = self.home!
                        
                        self.ballPos.setTitle(j["away"]["name"].string!,
                                              forSegmentAt: 0)
                        
                        self.ballPos.setTitle(j["home"]["name"].string!,
                                              forSegmentAt: 1)
                        
                        self.setTimeouts(false, data: j["away"]["timeouts"].int!)
                        self.setTimeouts(true, data: j["home"]["timeouts"].int!)
                        
                        self.initSubscriber()
                        self.initWS()
                        
                    }
                    
                }
                
        }
        
    } // loadGame
    
    
    func initSubscriber() {
        
        let url = "\(Mboard.WS)\(server!)/ws/subscriber"
        
        wsSubscribe = WebSocket(url)
        
        wsSubscribe.event.close = { code, reason, clean in
        }
        
        wsSubscribe.event.open = {
            print("websocket connected for subscriber")
            
            self.wsSubscribe.send(JSON([
                "cmd": "GAME_STATE"
                ]))

        }
        
        wsSubscribe.event.error = { error in
            
            let ac = UIAlertController(title: "Websocket error",
                                       message: error.localizedDescription,
                                       preferredStyle: UIAlertControllerStyle.alert)
            
            let OK = UIAlertAction(title: "OK",
                                   style: UIAlertActionStyle.default,
                                   handler: nil)
            
            ac.addAction(OK)
            
            self.present(ac, animated: true, completion: nil)
            
        }
        
        wsSubscribe.event.message = { message in
            
            if let txt = message as? String {
                
                var obj = JSON.init(parseJSON: txt)
        
                
                switch obj["key"] {
                case "CLOCK":
                    
                    let v = JSON.init(parseJSON: obj["val"].string!)
                    
                    self.setGameClock(v)
                    self.setShotClock(v)
                    
                    
                case "SHOT_VIOLATION":
                    
                    self.clockPause()
                    
                    // play sound on server side
                    
                    
                case "END_PERIOD":
                    
                    //self.nextPeriodBtn.isEnabled = true
                    self.endPeriod.isEnabled = true
                    self.clockPause()
                    
                    
                case "PERIOD":
                    
                    let p = obj["val"].string!
                    
                    self.period.text = Mboard.Periods[Int(p)!]
                    
                    
                case "POSSESSION_HOME":
                    self.ballPos.selectedSegmentIndex = 1
                    
                    
                case "POSSESSION_AWAY":
                    self.ballPos.selectedSegmentIndex = 0
                    
                case "HOME_TIMEOUT":
                    self.setTimeouts(true, data: Int(obj["val"].string!)!)
                    self.clockPause()
                    
                case "HOME_TIMEOUT_CANCEL":
                    self.setTimeouts(true, data: Int(obj["val"].string!)!)
                    
                case "AWAY_TIMEOUT":
                    self.setTimeouts(false, data: Int(obj["val"].string!)!)
                    self.clockPause()
                    
                case "AWAY_TIMEOUT_CANCEL":
                    self.setTimeouts(false, data: Int(obj["val"].string!)!)
                    
                case "GAME_STATE":
                    print("set the timeouts, clock or whatever")
                    
                default:
                    print("Unknown message from websocket.")
                    
                }
                
            }
        }

        
    } // initSubscriber
    
    func initWS() {
        
        let url = "\(Mboard.WS)\(server!)/ws/game"
        
        wsControl = WebSocket(url)
        
        wsControl.event.close = { code, reason, clean in
            print("websocket connection closed")
        }
        
        wsControl.event.open = {
            print("socket connected")
        }
        
        wsControl.event.error = { error in
            
            let ac = UIAlertController(title: "Websocket error",
                                       message: error.localizedDescription,
                                       preferredStyle: UIAlertControllerStyle.alert)
            
            let OK = UIAlertAction(title: "OK",
                                   style: UIAlertActionStyle.default,
                                   handler: nil)
            
            ac.addAction(OK)
            
            self.present(ac, animated: true, completion: nil)
            
        }
        
        wsControl.event.message = { message in
            print(message)
        }
        
    } // initWS
    
    func setTimeouts(_ home: Bool, data j: Int) {
        
        if home {
            self.homeTimeoutCount.text = "\(j)"
        } else {
            self.awayTimeoutCount.text = "\(j)"
        }
        
    } // setTimeouts
    
    // MARK: Actions
    
    @IBAction func toggleClock(_ sender: Any) {
        
        if running {
            
            wsControl.send(JSON([
                "cmd": Mboard.WS_CLOCK_STOP
                ]))
            
            clockPause()
            
        } else {
            
            wsControl.send(JSON([
                "cmd": Mboard.WS_CLOCK_START
                ]))
            
            clockUnpause()
            
        }
        
    }
    
    @IBAction func changePeriod(_ sender: Any) {
        
        wsControl.send(JSON([
            "cmd": Mboard.WS_PERIOD_UP
            ]))
        
        //nextPeriodBtn.isEnabled = false
        endPeriod.isEnabled = false
        
    }
    
    @IBAction func callAwayTimeout(_ sender: Any) {
        
        wsControl.send(JSON([
            "cmd": Mboard.WS_TIMEOUT_AWAY
            ]))
        
    }
    
    @IBAction func callHomeTimeout(_ sender: Any) {
        
        wsControl.send(JSON([
            "cmd": Mboard.WS_TIMEOUT_HOME
            ]))
        
    }
    
    @IBAction func cancelAwayTimeout(_ sender: Any) {
        
        wsControl.send(JSON([
            "cmd": Mboard.WS_TIMEOUT_AWAY_CANCEL
            ]))
        
    }
    
    @IBAction func cancelHomeTimeout(_ sender: Any) {
        
        wsControl.send(JSON([
            "cmd": Mboard.WS_TIMEOUT_HOME_CANCEL
            ]))
        
    }
    
    @IBAction func togglePossession(_ sender: UISegmentedControl) {
        
        switch ballPos.selectedSegmentIndex {
        case 0:
            
            wsControl.send(JSON([
                "cmd": Mboard.WS_POSSESSION_AWAY,
                "meta": ["stop": !running]
                ]))
            
            break
            
        case 1:
            
            wsControl.send(JSON([
                "cmd": Mboard.WS_POSSESSION_HOME,
                "meta": ["stop": !running]
                ]))
            
            break
            
        default:
            break
            
        }
    }
    
    @IBAction func adjustClock(_ sender: Any) {
        
        wsControl.send(JSON([
            "cmd": Mboard.WS_CLOCK_STOP
            ]))
            
        clockPause()
        
        self.performSegue(withIdentifier: "adjustSegue", sender: self)
        
    }
    
    
    
} // ClockController
