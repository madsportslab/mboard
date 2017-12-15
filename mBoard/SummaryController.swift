//
//  SummaryController.swift
//  mBoard
//
//  Created by hu on 5/2/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import AVKit

import Alamofire
import SwiftyJSON

class SummaryController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let defaults = UserDefaults.standard
    
    var logs = [[String]]()
    
    
    // MARK: Properties
    @IBOutlet weak var emptySB: UILabel!
    @IBOutlet weak var awayName: UILabel!
    @IBOutlet weak var a1: UILabel!
    @IBOutlet weak var a2: UILabel!
    @IBOutlet weak var a3: UILabel!
    @IBOutlet weak var a4: UILabel!
    @IBOutlet weak var aot: UILabel!
    @IBOutlet weak var at: UILabel!
    @IBOutlet weak var homeName: UILabel!
    @IBOutlet weak var h1: UILabel!
    @IBOutlet weak var h2: UILabel!
    @IBOutlet weak var h3: UILabel!
    @IBOutlet weak var h4: UILabel!
    @IBOutlet weak var hot: UILabel!
    @IBOutlet weak var ht: UILabel!
    @IBOutlet weak var logsTable: UITableView!
    @IBOutlet weak var homeLg: UILabel!
    @IBOutlet weak var awayLg: UILabel!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        progress.clipsToBounds = true
        progress.layer.cornerRadius = 10
        
        progress.startAnimating()
        
        view.bringSubview(toFront: progress)
        
        loadGame()
        loadLogs()
        
        logsTable.dataSource = self
        logsTable.delegate = self
        
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func translate(msg: String) -> (String, String) {
        
        //let ret = [String]()
        
        let j = JSON.parse(msg)
        
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
            return ("Away", "Timeout called")
        case Mboard.WS_FOUL_AWAY_DOWN:
            return ("Away", "Timeout retracted")
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
            
            if j["step"] == -1 {
              return ("Clock", "Step backward")
            } else if j["step"] == 1 {
              return ("Clock", "Step forward")
            } else {
                return ("Clock", "Step unknown")
            }
            
        case Mboard.WS_CLOCK_RESET:
            return ("Clock", "Reset")
        case Mboard.WS_SHOT_STEP:
            
            if j["step"] == -1 {
                return ("Clock", "Step backward")
            } else if j["step"] == 1 {
                return ("Clock", "Step forward")
            } else {
                return ("Clock", "Step unknown")
            }
            
        case Mboard.WS_SHOT_RESET:
            return ("Clock", "Reset")
        default:
            return ("Error", "Unreadable log message")
        }
        
    } // translate
    
    func setScoreboard(_ j:JSON, isHome:Bool) {
        
        var total = 0
        var ot    = 0
        
        for (k, v) in j {
            
            total = total + v.int!
            
            if k == "0" {
                
                if isHome {
                  self.h1.text = "\(v.int!)"
                } else {
                  self.a1.text = "\(v.int!)"
                }
                
            } else if k == "1" {
                
                if isHome {
                    self.h2.text = "\(v.int!)"
                } else {
                    self.a2.text = "\(v.int!)"
                }
                
            } else if k == "2" {
                
                if isHome {
                    self.h3.text = "\(v.int!)"
                } else {
                    self.a3.text = "\(v.int!)"
                }
                
            } else if k == "3" {
                
                if isHome {
                    self.h4.text = "\(v.int!)"
                } else {
                    self.a4.text = "\(v.int!)"
                }
                
            }

            let index = Int(k)
            
            if index! > 3 {
                ot = ot + v.int!
            }

        }
        
        if isHome {
            
            self.hot.text = "\(ot)"
            self.ht.text = "\(total)"
            self.homeScore.text = "\(total)"
            
        } else {
            
            self.aot.text = "\(ot)"
            self.at.text = "\(total)"
            self.awayScore.text = "\(total)"
            
        }
        
        
        
    } // setScoreboard
    
    
    func loadGame() {
    
        let ed = defaults.object(forKey: Mboard.SERVER) as? String
        let id = defaults.object(forKey: Mboard.GAME) as? String
        
        let url = "\(Mboard.HTTP)\(ed!)/api/scores" + "/\(id!)"

        print(url)
        
        self.progress.startAnimating()
        
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
                        
                        if j["data"]["Valid"].bool! {
                            
                            let data = JSON.parse(j["data"]["String"].string!)
                            
                            self.awayName.text = data["away"]["name"].string!
                            self.homeName.text = data["home"]["name"].string!
                            
                            self.awayLg.text = data["away"]["name"].string!
                            self.homeLg.text = data["home"]["name"].string!
                            
                            self.setScoreboard(data["away"]["points"], isHome: false)
                            self.setScoreboard(data["home"]["points"], isHome: true)
                            
                        
                        }
                    
                    }
                    
                }
                
                //self.progress.stopAnimating()
        }
        
    } // loadGame
    
    func loadLogs() {
        
        let ed = defaults.object(forKey: Mboard.SERVER) as? String
        let id = defaults.object(forKey: Mboard.GAME) as? String
        
        let url = "\(Mboard.HTTP)\(ed!)/api/scores" + "/\(id!)/logs"
        
        print(url)
        
        //self.progress.startAnimating()
        
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
                            
                            let msg = JSON.parse(v["msg"].string!)
                            let period = Mboard.Periods[msg["period"].int! + 1]
                            
                            let (t, l) = self.translate(msg: v["msg"].string!)
                            
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
                
                self.progress.stopAnimating()
        }
        
    } // loadLogs
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = logsTable.dequeueReusableCell(withIdentifier: "cell",
                                                  for: indexPath) as! LogViewCell
      
        //cell.selectionStyle = UITableViewCellSelectionStyle.blue
        
        cell.timestamp.layer.cornerRadius = 5
        cell.timestamp.layer.masksToBounds = true
        cell.timestamp.text = logs[indexPath.item][0]
        
        //cell.playTag.layer.cornerRadius = 5
        //cell.playTag.layer.masksToBounds = true
        //cell.playTag.text = logs[indexPath.item][1]
        
        cell.log.text = logs[indexPath.item][2]
        
        return cell
        
    }
    
    // MARK: Actions
    
} // SummaryController
