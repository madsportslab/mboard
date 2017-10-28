//
//  GameController.swift
//  mBoard
//
//  Created by hu on 3/31/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Alamofire
import Font_Awesome_Swift
import SwiftWebSocket
import SwiftyJSON


class GameController: UIViewController {
    
    var ws = WebSocket()
    
    var server:String?
    
    var totalTimeouts = 0
    
    let defaults = UserDefaults.standard
    
    // MARK: Properties
    @IBOutlet weak var m1AwayBtn: UIButton!
    @IBOutlet weak var p1AwayBtn: UIButton!
    @IBOutlet weak var m1HomeBtn: UIButton!
    @IBOutlet weak var p1HomeBtn: UIButton!
    @IBOutlet weak var m2AwayBtn: UIButton!
    @IBOutlet weak var p2AwayBtn: UIButton!
    @IBOutlet weak var m2HomeBtn: UIButton!
    @IBOutlet weak var p2HomeBtn: UIButton!
    @IBOutlet weak var m3AwayBtn: UIButton!
    @IBOutlet weak var p3AwayBtn: UIButton!
    @IBOutlet weak var m3HomeBtn: UIButton!
    @IBOutlet weak var p3HomeBtn: UIButton!
    @IBOutlet weak var mFAwayBtn: UIButton!
    @IBOutlet weak var pFAwayBtn: UIButton!
    @IBOutlet weak var mFHomeBtn: UIButton!
    @IBOutlet weak var pFHomeBtn: UIButton!
    @IBOutlet weak var endBtn: UIButton!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var awayFouls: UILabel!
    @IBOutlet weak var homeFouls: UILabel!
    @IBOutlet weak var awayName: UILabel!
    @IBOutlet weak var homeName: UILabel!
    @IBOutlet weak var m1Label: UILabel!
    @IBOutlet weak var m2Label: UILabel!
    @IBOutlet weak var m3Label: UILabel!
    @IBOutlet weak var foulLabel: UILabel!
    @IBOutlet weak var awayTimeouts: UILabel!
    @IBOutlet weak var homeTimeouts: UILabel!
    
    
    override func viewDidDisappear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        UIApplication.shared.isIdleTimerDisabled = true
    
        server = (defaults.object(forKey: Mboard.SERVER) as? String)!
        
        endBtn.layer.borderWidth = 1
        endBtn.layer.borderColor = Mboard.TealColor.cgColor
        endBtn.layer.cornerRadius = 5
        
        m1AwayBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        p1AwayBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        m1HomeBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        p1HomeBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        
        m2AwayBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        p2AwayBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        m2HomeBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        p2HomeBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        
        m3AwayBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        p3AwayBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        m3HomeBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        p3HomeBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        
        mFAwayBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        pFAwayBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        mFHomeBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        pFHomeBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        
        
        m1AwayBtn.layer.borderWidth = 1
        m1AwayBtn.layer.borderColor = Mboard.TealColor.cgColor
        m1AwayBtn.layer.cornerRadius = m1AwayBtn.bounds.size.width/2
        m1AwayBtn.layer.masksToBounds = true
        
        m2AwayBtn.layer.borderWidth = 1
        m2AwayBtn.layer.borderColor = Mboard.TealColor.cgColor
        m2AwayBtn.layer.cornerRadius = m2AwayBtn.bounds.size.width/2
        m2AwayBtn.layer.masksToBounds = true
        
        m3AwayBtn.layer.borderWidth = 1
        m3AwayBtn.layer.borderColor = Mboard.TealColor.cgColor
        m3AwayBtn.layer.cornerRadius = m3AwayBtn.bounds.size.width/2
        m3AwayBtn.layer.masksToBounds = true
        
        p1AwayBtn.layer.borderWidth = 1
        p1AwayBtn.layer.borderColor = Mboard.TealColor.cgColor
        p1AwayBtn.layer.cornerRadius = p1AwayBtn.bounds.size.width/2
        p1AwayBtn.layer.masksToBounds = true
        
        p2AwayBtn.layer.borderWidth = 1
        p2AwayBtn.layer.borderColor = Mboard.TealColor.cgColor
        p2AwayBtn.layer.cornerRadius = p2AwayBtn.bounds.size.width/2
        p2AwayBtn.layer.masksToBounds = true
        
        p3AwayBtn.layer.borderWidth = 1
        p3AwayBtn.layer.borderColor = Mboard.TealColor.cgColor
        p3AwayBtn.layer.cornerRadius = p3AwayBtn.bounds.size.width/2
        p3AwayBtn.layer.masksToBounds = true
        
        mFAwayBtn.layer.borderWidth = 1
        mFAwayBtn.layer.borderColor = Mboard.TealColor.cgColor
        mFAwayBtn.layer.cornerRadius = mFAwayBtn.bounds.size.width/2
        mFAwayBtn.layer.masksToBounds = true
        
        pFAwayBtn.layer.borderWidth = 1
        pFAwayBtn.layer.borderColor = Mboard.TealColor.cgColor
        pFAwayBtn.layer.cornerRadius = pFAwayBtn.bounds.size.width/2
        pFAwayBtn.layer.masksToBounds = true
        
        m1HomeBtn.layer.borderWidth = 1
        m1HomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        m1HomeBtn.layer.cornerRadius = m1HomeBtn.bounds.size.width/2
        m1HomeBtn.layer.masksToBounds = true
        
        m2HomeBtn.layer.borderWidth = 1
        m2HomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        m2HomeBtn.layer.cornerRadius = m2HomeBtn.bounds.size.width/2
        m2HomeBtn.layer.masksToBounds = true
        
        m3HomeBtn.layer.borderWidth = 1
        m3HomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        m3HomeBtn.layer.cornerRadius = m3HomeBtn.bounds.size.width/2
        m3HomeBtn.layer.masksToBounds = true
        
        p1HomeBtn.layer.borderWidth = 1
        p1HomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        p1HomeBtn.layer.cornerRadius = p1HomeBtn.bounds.size.width/2
        p1HomeBtn.layer.masksToBounds = true
        
        p2HomeBtn.layer.borderWidth = 1
        p2HomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        p2HomeBtn.layer.cornerRadius = p2HomeBtn.bounds.size.width/2
        p2HomeBtn.layer.masksToBounds = true
        
        p3HomeBtn.layer.borderWidth = 1
        p3HomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        p3HomeBtn.layer.cornerRadius = p3HomeBtn.bounds.size.width/2
        p3HomeBtn.layer.masksToBounds = true
        
        mFHomeBtn.layer.borderWidth = 1
        mFHomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        mFHomeBtn.layer.cornerRadius = mFHomeBtn.bounds.size.width/2
        mFHomeBtn.layer.masksToBounds = true
        
        pFHomeBtn.layer.borderWidth = 1
        pFHomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        pFHomeBtn.layer.cornerRadius = pFHomeBtn.bounds.size.width/2
        pFHomeBtn.layer.masksToBounds = true
        
        m1Label.layer.cornerRadius = 5
        m1Label.layer.borderColor = UIColor.white.cgColor
        m1Label.layer.masksToBounds = true
        
        m2Label.layer.cornerRadius = 5
        m2Label.layer.borderColor = UIColor.white.cgColor
        m2Label.layer.masksToBounds = true
        
        m3Label.layer.cornerRadius = 5
        m3Label.layer.borderColor = UIColor.white.cgColor
        m3Label.layer.masksToBounds = true
        
        foulLabel.layer.cornerRadius = 5
        foulLabel.layer.borderColor = UIColor.white.cgColor
        foulLabel.layer.masksToBounds = true
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changePoints(points: Int) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_HOME,
            "step": points
            
        ]));
        
    } // changePoints
    
    
    func initWS() {
    
        let url = "\(Mboard.WS)\(server!)/ws/game"
        
        ws = WebSocket(url)
        
        ws.event.close = { code, reason, clean in
          
          print("close")
          self.ws.open()
            
        }
        
        ws.event.open = {
            print("socket connected")
        }
        
        ws.event.error = { error in
            print(error)
        }
        
        ws.event.message = { message in
            print(message)
            
            if let txt = message as? String {
                
                var obj = JSON.parse(txt)
            
                switch obj["key"] {
                case "HOME_SCORE":
                    self.homeScore.text = obj["val"].string!
                case "AWAY_SCORE":
                    self.awayScore.text = obj["val"].string!
                case "HOME_FOUL":
                    self.homeFouls.text = "\(obj["val"].string!)"
                case "AWAY_FOUL":
                    self.awayFouls.text = "\(obj["val"].string!)"
                case "HOME_TIMEOUT":
                    self.setTimeouts(true, data: Int(obj["val"].string!)!)
                case "AWAY_TIMEOUT":
                    self.setTimeouts(false, data: Int(obj["val"].string!)!)
                    
                default:
                    print(obj["key"])
                    print("Unknown message from websocket.")
                }
                
            }
        }
        
    } // initWS
    
    
    func setTimeouts(_ home: Bool, data j: Int) {
    
        if home {
            self.homeTimeouts.text = "\(j)"
        } else {
            self.awayTimeouts.text = "\(j)"
        }
        
    } // setTimeouts
    
    func setFouls(_ home: Bool, data j: Int) {
        
        if home {
            self.homeFouls.text = "\(j)"
        } else {
            self.awayFouls.text = "\(j)"
        }
        
    } // setFouls
    
    
    func setTotalPoints(_ home: Bool, data j: JSON) {
    
        var total = 0
        
        for (_,v) in j {
            
            print(v)
            
            total = total + v.int!
            
        }
    
        if home {
            self.homeScore.text = "\(total)"
        } else {
            self.awayScore.text = "\(total)"
        }
        
    } // totalPoints
    
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
                    
                    self.defaults.set(
                        String(j["id"].int!), forKey: Mboard.GAME)

                    self.awayName.text = j["away"]["name"].string!
                    self.homeName.text = j["home"]["name"].string!

                    self.setTotalPoints(false, data: j["away"]["points"])
                    self.setFouls(false, data: j["away"]["fouls"].int!)
                    self.setTimeouts(false, data: j["away"]["timeouts"].int!)
                    
                    self.setTotalPoints(true, data: j["home"]["points"])
                    self.setFouls(true, data: j["home"]["fouls"].int!)
                    self.setTimeouts(true, data: j["home"]["timeouts"].int!)
                    
                    
                    self.initWS()
                    
                    
                    
                }
                
            }
                
        }
        
    } // loadGame
    
    
    
    func storeGame() {
        
        let ed = defaults.object(forKey: Mboard.SERVER) as? String
        
        let url = "\(Mboard.HTTP)\(ed!)/api/games"
        
        Alamofire.request(url, method: .put)
            .response{ response in
                
                if response.error != nil {
                    
                    let ac = UIAlertController(title: "End game error",
                                               message: response.error?.localizedDescription,
                                               preferredStyle: UIAlertControllerStyle.alert)
                    
                    let OK = UIAlertAction(title: "OK",
                                           style: UIAlertActionStyle.default,
                                           handler: nil)
                    
                    ac.addAction(OK)
                    
                    self.present(ac, animated: true, completion: nil)
                    
                } else {
                    self.performSegue(withIdentifier: "endGameSegue", sender: self)
                }
                
        }
        
    } // storeGame
    
    // MARK: Actions
    
    @IBAction func pt1MadeAway(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_AWAY,
            "step": 1
            ]))
        
    }
    
    @IBAction func pt1MissAway(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_AWAY,
            "step": -1
            ]))
        
    }
    
    @IBAction func pt2MadeAway(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_AWAY,
            "step": 2
            ]))
        
    }
    
    @IBAction func pt2MissAway(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_AWAY,
            "step": -2
            ]))
        
    }
    
    @IBAction func pt3MadeAway(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_AWAY,
            "step": 3
            ]))
        
    }
    
    @IBAction func pt3MissAway(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_AWAY,
            "step": -3
            ]))
        
    }
    
    @IBAction func pt1MadeHome(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_HOME,
            "step": 1
            ]))
        
    }
    
    @IBAction func pt1MissHome(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_HOME,
            "step": -1
            ]))
        
    }
    
    @IBAction func pt2MadeHome(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_HOME,
            "step": 2
            ]))
        
    }
    
    @IBAction func pt2MissHome(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_HOME,
            "step": -2
            ]))
        
    }
    
    @IBAction func pt3MadeHome(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_HOME,
            "step": 3
            ]))
        
    }
    
    @IBAction func pt3MissHome(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_HOME,
            "step": -3
            ]))
        
    }
    
    @IBAction func foulRmAway(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_FOUL_AWAY_DOWN
            ]))
        
    }
    
    @IBAction func foulAddAway(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_FOUL_AWAY_UP
            ]))
        
    }
    
    @IBAction func foulRmHome(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_FOUL_HOME_DOWN
            ]))
        
    }
    
    @IBAction func foulAddHome(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_FOUL_HOME_UP
            ]))
        
    }
    
    @IBAction func endGame(_ sender: Any) {
        
        let ac = UIAlertController(title: "End game",
                                   message: "Changes cannot be made after you've ended the game. Are you sure you want to end the game?",
                                   preferredStyle: UIAlertControllerStyle.alert)
        
        let OK = UIAlertAction(title: "OK",
                               style: UIAlertActionStyle.default,
                               handler: { (action: UIAlertAction!) in
                                self.storeGame()
        })
        
        let CancelAction = UIAlertAction(title: "Cancel",
                               style: UIAlertActionStyle.default,
                               handler: nil)
        
        ac.addAction(OK)
        ac.addAction(CancelAction)
        
        self.present(ac, animated: true, completion: nil)
        
    }

    
    
    
    
} // GameController
