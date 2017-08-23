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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        logsTable.delegate = self
        logsTable.dataSource = self
        
        loadLogs()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func translate(msg: String) -> String {
        
        let j = JSON.parse(msg)
        
        print(j)
        
        switch j["cmd"].string! {
            
        case "SCORE_AWAY":
            return "Away, \(j["step"].int!) points"
        case "SCORE_HOME":
            return "Home, \(j["step"].int!) points"
        case "TIMEOUT_HOME_UP":
            return "Home, timeout called"
        case "TIMEOUT_HOME_DOWN":
            return "Home, timeout cancelled"
        case "TIMEOUT_AWAY_UP":
            return "Away, timeout called"
        case "TIMEOUT_AWAY_DOWN":
            return "Away, timeout cancelled"
        case "FOUL_HOME_UP":
            return "Home, foul called"
        case "FOUL_HOME_DOWN":
            return "Home, foul cancelled"
        case "FOUL_AWAY_UP":
            return "Away, timeout called"
        case "FOUL_AWAY_DOWN":
            return "Away, timeout cancelled"
        case "POSSESSION_HOME":
            return "Home, possession"
        case "POSSESSION_AWAY":
            return "Away, possession"
        case "CLOCK_START":
            return "Clock started"
        case "CLOCK_STOP":
            return "Clock stopped"
        default:
            return "unreadable log message"
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
        
        cell.log.text = logs[indexPath.item][0]
        
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
                            let l = self.translate(msg: v["msg"].string!)
                            
                            let f2 = DateFormatter()
                            
                            f2.dateFormat = "HH:mm:ss"
                            
                            let d2 = f2.string(from: d!)
                            
                            log.append("\(d2) - \(l)")
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
