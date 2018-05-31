//
//  ScoreboardSettingController.swift
//  mBoard
//
//  Created by hu on 5/25/18.
//  Copyright © 2018 madsportslab. All rights reserved.
//

import UIKit

import Font_Awesome_Swift
import SwiftWebSocket
import SwiftyJSON

class ScoreboardSettingController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    var ws = WebSocket()
    var wsSubscribe = WebSocket()
    
    // MARK: Properties
    @IBOutlet weak var themes: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        initSubscriber()
        initWS()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSubscriber() {
        
        let ed = defaults.object(forKey: Mboard.SERVER) as? String
        let url = "\(Mboard.WS)\(ed!)/ws/subscriber"
        
        wsSubscribe = WebSocket(url)
        
        wsSubscribe.event.close = { code, reason, clean in
            print("close")
        }
        
        wsSubscribe.event.open = {
            print("websocket connected for subscriber")
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
                
                let o = JSON(obj["options"])
                
                print(o)
                
                if o["current-theme"] == "ORANGE" {
                    self.themes.selectedSegmentIndex = 1
                } else if o["current-theme"] == "DEFAULT" {
                    self.themes.selectedSegmentIndex = 0
                } else if o["current-theme"] == "TEAL" {
                    self.themes.selectedSegmentIndex = 2
                }
                

            }
        }
        
    } // initSubscriber
    
    func initWS() {
        
        let ed = defaults.object(forKey: Mboard.SERVER) as? String
        let url = "\(Mboard.WS)\(ed!)/ws/manager"
        
        ws = WebSocket(url)
        
        ws.event.close = { code, reason, clean in
            print("websocket connection closed")
        }
        
        ws.event.open = {
            print("manager websocket connected")
            
            self.ws.send(JSON([
                "cmd": Mboard.WS_THEME_CURRENT
                ]))
            
        }
        
        ws.event.error = { error in
            
            let ac = UIAlertController(title: "Websocket error",
                                       message: error.localizedDescription,
                                       preferredStyle: UIAlertControllerStyle.alert)
            
            let OK = UIAlertAction(title: "OK",
                                   style: UIAlertActionStyle.default,
                                   handler: nil)
            
            ac.addAction(OK)
            
            self.present(ac, animated: true, completion: nil)
            
        }
        
        ws.event.message = { message in
            
            //if let txt = message as? String {
                
                
            //}
        }
        
    } // initWS
    
    // MARK: Actions
    
    @IBAction func changeTheme(_ sender: Any) {
        
        if self.themes.selectedSegmentIndex == 0 {
            ws.send(JSON([
                "cmd": Mboard.WS_SCOREBOARD
                ]))
        } else if self.themes.selectedSegmentIndex == 1 {
            ws.send(JSON([
                "cmd": Mboard.WS_THEME,
                "options": ["theme": "orange","view": "scoreboard"]
                ]))
        } else if self.themes.selectedSegmentIndex == 2 {
            ws.send(JSON([
                "cmd": Mboard.WS_THEME,
                "options": ["theme": "teal","view": "scoreboard"]
                ]))
        }
        
        
    }
    
} // ScoreboardSettingController
