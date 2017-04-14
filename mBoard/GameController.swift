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
    @IBOutlet weak var mTAwayBtn: UIButton!
    @IBOutlet weak var pTAwayBtn: UIButton!
    @IBOutlet weak var mTHomeBtn: UIButton!
    @IBOutlet weak var pTHomeBtn: UIButton!
    @IBOutlet weak var endBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var lastPlay: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var awayTimeouts: UILabel!
    @IBOutlet weak var homeTimeouts: UILabel!
    @IBOutlet weak var awayFouls: UILabel!
    @IBOutlet weak var homeFouls: UILabel!
    
    override func viewDidDisappear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        UIApplication.shared.isIdleTimerDisabled = true
        
        awayTimeouts.setFAIcon(icon: FAType.FACircle, iconSize: 12)
        lastPlay.layer.borderWidth = 1
        //lastPlay.layer.cornerRadius = 5
        lastPlay.layer.borderColor = Mboard.YellowColor.cgColor
        
        backBtn.layer.borderWidth = 1
        backBtn.layer.cornerRadius = 5
        backBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        //backBtn.setFAIcon(icon: FAType.FAArrowLeft, forState: .normal)
        
        endBtn.layer.borderWidth = 1
        endBtn.layer.borderColor = UIColor.red.cgColor
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
        
        mTAwayBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        pTAwayBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        mTHomeBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        pTHomeBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        
        
        m1AwayBtn.layer.borderWidth = 1
        m1AwayBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        m2AwayBtn.layer.borderWidth = 1
        m2AwayBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        m3AwayBtn.layer.borderWidth = 1
        m3AwayBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        p1AwayBtn.layer.borderWidth = 1
        p1AwayBtn.layer.borderColor = Mboard.TealColor.cgColor

        p2AwayBtn.layer.borderWidth = 1
        p2AwayBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        p3AwayBtn.layer.borderWidth = 1
        p3AwayBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        mFAwayBtn.layer.borderWidth = 1
        mFAwayBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        pFAwayBtn.layer.borderWidth = 1
        pFAwayBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        mTAwayBtn.layer.borderWidth = 1
        mTAwayBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        pTAwayBtn.layer.borderWidth = 1
        pTAwayBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        m1HomeBtn.layer.borderWidth = 1
        m1HomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        m2HomeBtn.layer.borderWidth = 1
        m2HomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        m3HomeBtn.layer.borderWidth = 1
        m3HomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        p1HomeBtn.layer.borderWidth = 1
        p1HomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        p2HomeBtn.layer.borderWidth = 1
        p2HomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        p3HomeBtn.layer.borderWidth = 1
        p3HomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        mFHomeBtn.layer.borderWidth = 1
        mFHomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        pFHomeBtn.layer.borderWidth = 1
        pFHomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        mTHomeBtn.layer.borderWidth = 1
        mTHomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        pTHomeBtn.layer.borderWidth = 1
        pTHomeBtn.layer.borderColor = Mboard.TealColor.cgColor
        
        createGame()

        loadGame()
        
        initWS()
        

        
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
            print(message)
            
            if let txt = message as? String {
                
                var obj = JSON.parse(txt)
            
                switch obj["key"] {
                case "HOME_SCORE":
                    self.homeScore.text = obj["val"].string!
                case "AWAY_SCORE":
                    self.awayScore.text = obj["val"].string!
                default:
                    print("no")
                }
                
            }
        }
        
    } // initWS
    
    
    func loadGame() {
        
        Alamofire.request(Mboard.GAMES)
            .responseJSON{ response in
        
            switch response.result {
            case .failure(let error):
                
                let ac = UIAlertController(title: "Connection error",
                                           message: error.localizedDescription,
                                           preferredStyle: UIAlertControllerStyle.alert)
                
                let OK = UIAlertAction(title: "OK",
                                       style: UIAlertActionStyle.default,
                                       handler: nil)
                
                ac.addAction(OK)
                
                self.present(ac, animated: true, completion: nil)
                
            case .success:
                
                if let raw = response.result.value {
                
                    let j = JSON(raw)
                    
                    print(j)
                    
                }
                
            }
                
        }
        
    } // loadGame
    
    
    func createGame() {
        
        Alamofire.request(Mboard.GAMES, method: .post)
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
                    
                }
                
        }
        
    } // createGame
    
    
    // MARK: Actions
    
    @IBAction func pt1MadeAway(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_AWAY,
            "step": 1
            ]));
        
    }
    
    @IBAction func pt1MissAway(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_AWAY,
            "step": -1
            ]));
        
    }
    
    @IBAction func pt2MadeAway(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_AWAY,
            "step": 2
            ]));
        
    }
    
    @IBAction func pt2MissAway(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_AWAY,
            "step": -2
            ]));
        
    }
    
    @IBAction func pt3MadeAway(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_AWAY,
            "step": 3
            ]));
        
    }
    
    @IBAction func pt3MissAway(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_AWAY,
            "step": -3
            ]));
        
    }
    
    @IBAction func pt1MadeHome(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_HOME,
            "step": 1
            ]));
        
    }
    
    @IBAction func pt1MissHome(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_HOME,
            "step": -1
            ]));
        
    }
    
    @IBAction func pt2MadeHome(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_HOME,
            "step": 2
            ]));
        
    }
    
    @IBAction func pt2MissHome(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_HOME,
            "step": -2
            ]));
        
    }
    
    @IBAction func pt3MadeHome(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_HOME,
            "step": 3
            ]));
        
    }
    
    @IBAction func pt3MissHome(_ sender: Any) {
    
        ws.send(JSON([
            "cmd": Mboard.WS_SCORE_HOME,
            "step": -3
            ]));
        
    }
    
    @IBAction func foulRmAway(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_FOUL_AWAY_DOWN
            ]));
        
    }
    
    @IBAction func foulAddAway(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_FOUL_AWAY_UP
            ]));
        
    }
    
    @IBAction func foulRmHome(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_FOUL_HOME_DOWN
            ]));
        
    }
    
    @IBAction func foulAddHome(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_FOUL_HOME_UP
            ]));
        
    }
    
    @IBAction func timeRmAway(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_TIMEOUT_AWAY_DOWN
            ]));
        
    }
    
    @IBAction func timeAddAway(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_TIMEOUT_AWAY_UP
            ]));
        
    }
    
    @IBAction func timeRmHome(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_TIMEOUT_HOME_DOWN
            ]));
        
    }
    
    @IBAction func timeAddHome(_ sender: Any) {
        
        ws.send(JSON([
            "cmd": Mboard.WS_TIMEOUT_HOME_UP
            ]));
        
    }
    
    
} // GameController
