//
//  FirstViewController.swift
//  mBoard
//
//  Created by hu on 3/28/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Alamofire
import Font_Awesome_Swift
import SwiftWebSocket
import SwiftyJSON

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ws = WebSocket()
    var gameInfo = [[String]]()
    
    let defaults = UserDefaults.standard
    let thead    = ["Previous Games"]
    
    // MARK: Properties
    @IBOutlet weak var gamesTable: UITableView!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var playGameBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //newGameBtn.layer.borderWidth = 1
        //newGameBtn.layer.borderColor = Mboard.TealColor.cgColor
        //newGameBtn.layer.cornerRadius = 5

        getScores()

        gamesTable.delegate = self
        gamesTable.dataSource = self
        
        // try defaults IP address, if failed then connect server btn needs to appear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = gamesTable.dequeueReusableCell(withIdentifier: "cell",
                for: indexPath) as! GameViewCell
        
        cell.awayTeam.text = gameInfo[indexPath.item][0]
        cell.awayLogo.setFAIcon(icon: FAType.FAPictureO, iconSize: 48)
        cell.awayScore.text = gameInfo[indexPath.item][1]
        
        cell.homeTeam.text = gameInfo[indexPath.item][2]
        cell.homeLogo.setFAIcon(icon: FAType.FAPictureO, iconSize: 48)
        cell.homeScore.text = gameInfo[indexPath.item][3]
        
        //cell.backgroundColor = Mboard.TealColor
        //cell.layer.borderColor = Mboard.TealColor.cgColor
        //cell.layer.borderWidth = 1
        //cell.layer.cornerRadius = 5
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        defaults.set(gameInfo[indexPath.item][4], forKey: Mboard.GAME)
        self.performSegue(withIdentifier: "summarySegue", sender: self)
        
    }
    
    /*func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.thead[section]
    }*/
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let v = UIView(frame: CGRect(x: 0, y:0, width: view.frame.size.width,
                                     height: 32))
        
        let l = UILabel(frame: CGRect(x: 10, y: 7, width: view.frame.size.width,
                                      height: 24))
        
        l.text = thead[section]
        l.textColor = Mboard.NeonGreenColor
        v.addSubview(l)
        
        return v
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
        
            let ed = defaults.object(forKey: Mboard.SERVER) as? String
            
            let url = "\(Mboard.HTTP)\(ed!)/api/scores/\(gameInfo[indexPath.item][4])"
            
            self.progress.startAnimating()
            
            Alamofire.request(url, method: .delete)
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
                        
                    } else if let status = response.response?.statusCode {
                     
                        if status == 404 {
                            
                            print("not found")

                            
                        } else {
                        
                            self.gameInfo.remove(at: indexPath.item)
                            
                            self.gamesTable.deleteRows(at: [indexPath], with: .fade)
                            
                            self.gamesTable.reloadData()
                            
                        }
                        
                    }
                    
                    self.progress.stopAnimating()
                    
            }
            
        }
        
    }
    
    func totalScore(_ j:JSON) -> String {
        
        var t = 0
        
        for (_, x) in j {
            t = t + x.int!
        }

        return "\(t)"
        
        
    } // totalScore
    
    func scoreSummary(_ j:JSON) -> String {
        
        if j["data"]["Valid"].bool! {
            
            let data = JSON.parse(j["data"]["String"].string!)
            
            return totalScore(data)
            
            
        } else {
            return "Away: 0 - Home: 0"
        }
        
        
    } // scoreSummary
    
    func getScores() {
        
        let ed = defaults.object(forKey: Mboard.SERVER) as? String
        
        let url = "\(Mboard.HTTP)\(ed!)/api/scores"
        
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
                        
                        var tbody = [[String]]()
                        
                        //tbody.append(self.thead)
                        
                        for (_, v) in j {

                            print(v)
                            
                            if v["status"].int == 1 {
                                
                                var row = [String]()
                                
                                if v["data"]["Valid"].bool! {
                                    
                                    let data = JSON.parse(v["data"]["String"].string!)
                                    
                                    if !data["away"]["name"].string!.isEmpty {
                                      row.append(data["away"]["name"].string!)
                                    } else {
                                      row.append("Away")
                                    }
                                    
                                    row.append(self.totalScore(data["away"]["points"]))
                                    
                                    if !data["home"]["name"].string!.isEmpty {
                                        row.append(data["home"]["name"].string!)
                                    } else {
                                        row.append("Home")
                                    }
                                    
                                    row.append(self.totalScore(data["home"]["points"]))
                                    
                                    row.append(v["id"].string!)
                                    
                                } else {
                                
                                    row.append("Away")
                                    row.append("0")
                                    row.append("Home")
                                    row.append("0")
                                    row.append(v["id"].string!)
                                    
                                }
                                
                                let now = Date()
                                
                                let formatter = DateFormatter()
                                
                                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                                
                                print(v["created"].string!)
                                
                                let d = formatter.date(
                                    from: v["created"].string!)
                                
                                let f = DateComponentsFormatter()
                                    
                                f.allowedUnits = [.day, .hour, .minute, .second]
                                f.unitsStyle = .abbreviated
                                f.maximumUnitCount = 1
                                
                                let s = f.string(from: d!, to: now)
                                
                                row.append(s!)

                                tbody.append(row)

                            }
                            

                        }
                        
                        self.gameInfo = tbody
                        
                        self.gamesTable.reloadData()
                        
                    }
                    
                    
                    
                }
                
                self.progress.stopAnimating()
                
        }
        
        
    } // getScores
    
    func checkActiveGame() {
        
        let ed = defaults.object(forKey: Mboard.SERVER) as? String
        
        let url = "\(Mboard.HTTP)\(ed!)/api/games"
        
        Alamofire.request(url, method: .get)
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
                        
                } else if let status = response.response?.statusCode {
                    
                    print(status)
                    if status == 404 {
                        
                        self.performSegue(withIdentifier: "gameSettingsSegue",
                                          sender: self)
                        
                    } else {
                        self.performSegue(withIdentifier: "currentGameSegue",
                                          sender: self)
                    }
                    
                }
                
        }
        
        
    } // checkActiveGame

    
    // MARK: Actions
    
    @IBAction func playGame(_ sender: Any) {
        checkActiveGame()
    }

}

