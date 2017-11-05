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
        
        incrGameBtn.setFAIcon(icon: FAType.FAStepForward, iconSize: 32, forState: .normal)
        decrGameBtn.setFAIcon(icon: FAType.FAStepBackward, iconSize: 32, forState: .normal)
        resetGameBtn.setFAIcon(icon: FAType.FARefresh, iconSize: 32, forState: .normal)
        
        incrShotBtn.setFAIcon(icon: FAType.FAStepForward, iconSize: 32, forState: .normal)
        decrShotBtn.setFAIcon(icon: FAType.FAStepBackward, iconSize: 32, forState: .normal)
        resetShotBtn.setFAIcon(icon: FAType.FARefresh, iconSize: 32, forState: .normal)
        
        incrGameBtn.layer.borderWidth = 1
        incrGameBtn.layer.backgroundColor = UIColor.clear.cgColor
        incrGameBtn.layer.borderColor = UIColor.red.cgColor
        
        decrGameBtn.layer.borderWidth = 1
        decrGameBtn.layer.backgroundColor = UIColor.clear.cgColor
        decrGameBtn.layer.borderColor = UIColor.red.cgColor
        
        resetGameBtn.layer.borderWidth = 1
        resetGameBtn.layer.backgroundColor = UIColor.clear.cgColor
        resetGameBtn.layer.borderColor = UIColor.red.cgColor
        
        incrShotBtn.layer.borderWidth = 1
        incrShotBtn.layer.backgroundColor = UIColor.clear.cgColor
        incrShotBtn.layer.borderColor = UIColor.red.cgColor
        
        decrShotBtn.layer.borderWidth = 1
        decrShotBtn.layer.backgroundColor = UIColor.clear.cgColor
        decrShotBtn.layer.borderColor = UIColor.red.cgColor
        
        resetShotBtn.layer.borderWidth = 1
        resetShotBtn.layer.backgroundColor = UIColor.clear.cgColor
        resetShotBtn.layer.borderColor = UIColor.red.cgColor
        
        loadGame()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                        
                        //self.setGameClock(j)
                        //self.setShotClock(j)
                        
                        //self.awayPos.setTitle(j["away"]["name"].string!, for: .normal)
                        //self.homePos.setTitle(j["home"]["name"].string!, for: .normal)
                        
                        //self.initWS()
                        
                    }
                    
                }
                
        }
        
    } // loadGame
    
    
    // MARK: Actions
    
} // AdjustClock

