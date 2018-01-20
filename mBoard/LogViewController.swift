//
//  LogViewController.swift
//  mBoard
//
//  Created by hu on 8/12/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

class LogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let defaults = UserDefaults.standard
    
    var logs = [[String]]()
    
    // MARK: Properties
    @IBOutlet weak var logsTable: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        loadLogs()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        logsTable.delegate = self
        logsTable.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func translate(msg: String) -> (String, String) {
        
        let j = JSON.init(parseJSON: msg)
        
        print(j)
        
        switch j["cmd"].string! {
            
        case Mboard.WS_SCORE_AWAY:
            return ("Away", "\(j["step"].int!) points")
        case Mboard.WS_SCORE_HOME:
            return ("Home", "\(j["step"].int!) points")
        case Mboard.WS_TIMEOUT_HOME:
            return ("Home", "Timeout called")
            
        case Mboard.WS_TIMEOUT_HOME_CANCEL:
            return ("Home", "Timeout retracted")
            
        case Mboard.WS_TIMEOUT_AWAY:
            return ("Away", "Timeout called")
            
        case Mboard.WS_TIMEOUT_AWAY_CANCEL:
            return ("Away", "Timeout retracted")
            
        case Mboard.WS_FOUL_HOME_UP:
            return ("Home", "Foul called")
        case Mboard.WS_FOUL_HOME_DOWN:
            return ("Home", "Foul retracted")
        case Mboard.WS_FOUL_AWAY_UP:
            return ("Away", "Foul called")
        case Mboard.WS_FOUL_AWAY_DOWN:
            return ("Away", "Foul retracted")
        case Mboard.WS_POSSESSION_HOME:
            return ("Home", "Possession change")
        case Mboard.WS_POSSESSION_AWAY:
            return ("Away", "Possession change")
        case Mboard.WS_CLOCK_START:
            return ("Clock", "Started")
        case Mboard.WS_CLOCK_STOP:
            return ("Clock", "Stopped")
        case Mboard.WS_PERIOD_UP:
            return ("Game", "Period end")
        case Mboard.WS_CLOCK_STEP:
            return ("Clock", "Clock forward.")
        case Mboard.WS_CLOCK_RESET:
            return ("Clock", "clock reset.")
        case Mboard.WS_SHOT_STEP:
            return ("Clock", "Clock forward.")
        case Mboard.WS_SHOT_RESET:
            return ("Clock", "clock reset.")
        default:
            return ("Error", "Unreadable log message")
        }
        
    } // translate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = logsTable.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath) as! LogViewCell
        
        cell.timestamp.layer.cornerRadius = 5
        cell.timestamp.layer.masksToBounds = true
        cell.timestamp.text = logs[indexPath.item][0]

        //cell.playTag.layer.cornerRadius = 5
        //cell.playTag.layer.masksToBounds = true
        //cell.playTag.text = logs[indexPath.item][1]
        
        cell.log.text = logs[indexPath.item][2]
        
        return cell
        
    }
    
    func loadLogs() {
        
        let ed = defaults.object(forKey: Mboard.SERVER) as? String
        let id = defaults.object(forKey: Mboard.GAME) as? String
        
        let url = "\(Mboard.HTTP)\(ed!)/api/scores" + "/\(id!)/logs"
        
        print(url)
        
        Alamofire.request(url, method: .get)
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
                        
                        var data = [[String]]()
                        
                        for (_, v) in j {
                            
                            var log = [String]()
                            
                            let f = DateFormatter()
                            
                            f.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                            
                            let d = f.date(from: v["created"].string!)
                            let (t, l) = self.translate(msg: v["msg"].string!)
                            
                            let f2 = DateFormatter()
                            
                            f2.dateFormat = "HH:mm:ss"
                            
                            let d2 = f2.string(from: d!)
                            
                            print(d2)
                            //log.append(d2)
                            
                            let msg = JSON.init(parseJSON: v["msg"].string!)
                            
                            let period = Mboard.Periods[msg["period"].int!]
                            
                            log.append("\(v["clock"].string!) \(period) - \(t)")
                            log.append(t)
                            log.append(l)
                            log.append(v["id"].string!)
                        
                            data.append(log)
                            
                        }
                        
                        self.logs = data
                        
                        self.logsTable.reloadData()
                        
                        
                    }
                    
                }
        }
        
    } // loadLogs
    
    // MARK: Actions
    
} // LogViewController
