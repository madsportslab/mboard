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

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var ws = WebSocket()
    var gameInfo = [[String]]()
    
    let defaults = UserDefaults.standard
    let thead    = ["Previous Games"]
    
    // MARK: Properties
    @IBOutlet weak var newGameBtn: UIButton!
    @IBOutlet weak var gamesCollection: UICollectionView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //newGameBtn.layer.borderWidth = 1
        //newGameBtn.layer.borderColor = Mboard.TealColor.cgColor
        //newGameBtn.layer.cornerRadius = 15

        getScores()

        //newGameBtn.setFAIcon(icon: FAType.FASoccerBallO, iconSize: 72, forState: .normal)
        //newGameBtn.setFATitleColor(color: UIColor.white)
        newGameBtn.setTitleColor(UIColor.white, for: .normal)
        
        //gamesTable.layer.borderWidth = 1
        //gamesTable.layer.borderColor = UIColor.white.cgColor
        
        gamesCollection.delegate = self
        gamesCollection.dataSource = self
        
        // try defaults IP address, if failed then connect server btn needs to appear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }*/
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameInfo.count
    }
    
    /*func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(gameInfo.count)
        return gameInfo.count
    }*/
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = gamesCollection.dequeueReusableCell(withReuseIdentifier: "cell",
                                                  for: indexPath) as! GameViewCell
        
        cell.awayTeam.text = gameInfo[indexPath.item][0]
        cell.awayLogo.setFAIcon(icon: FAType.FAPictureO, iconSize: 48)
        cell.awayScore.text = gameInfo[indexPath.item][1]
        
        cell.homeTeam.text = gameInfo[indexPath.item][2]
        cell.homeLogo.setFAIcon(icon: FAType.FAPictureO, iconSize: 48)
        cell.homeScore.text = gameInfo[indexPath.item][3]
        
        cell.backgroundColor = Mboard.TealColor
        cell.layer.cornerRadius = 5
        
        return cell
    
    }
    
    /*
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = gamesTable.dequeueReusableCell(withIdentifier: "cell",
            for: indexPath) as! GameViewCell
        
        cell.awayTeam.text = gameInfo[indexPath.item][0]
        cell.awayLogo.setFAIcon(icon: FAType.FAPictureO, iconSize: 48)
        cell.awayScore.text = gameInfo[indexPath.item][1]
        
        cell.homeTeam.text = gameInfo[indexPath.item][2]
        cell.homeLogo.setFAIcon(icon: FAType.FAPictureO, iconSize: 48)
        cell.homeScore.text = gameInfo[indexPath.item][3]
        
        cell.backgroundColor = Mboard.TealColor
        //cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        
        return cell
        
    }*/
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.thead[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let v = UIView(frame: CGRect(x: 0, y:0, width: view.frame.size.width,
                                     height: 32))
        
        v.backgroundColor = Mboard.TealColor
        
        let l = UILabel(frame: CGRect(x: 10, y: 7, width: view.frame.size.width,
                                      height: 24))
        
        l.text = thead[section]
        l.textColor = Mboard.NeonGreenColor
        v.addSubview(l)
        
        return v
        
    }*/
    
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
        
        Alamofire.request(url, method: .get)
            .responseJSON{ response in
                
                switch response.result {
                case .failure(let error):
                    
                    print(error)
                    
                    
                case .success:
                    
                    if let raw = response.result.value {
                        
                        let j = JSON(raw)
                        
                        print(j)
                        
                        var tbody = [[String]]()
                        
                        //tbody.append(self.thead)
                        
                        for (_, v) in j {

                            print("shit")
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
                                    
                                    
                                } else {
                                
                                    row.append("Away")
                                    row.append("0")
                                    row.append("Home")
                                    row.append("0")

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
                                    
                                print(s!)
                                
                                //print(now)
                                //print(d?.timeIntervalSinceNow)
                                
                                //let since = now - d
                                
                                //print(since)
                                
                                //row.append(String(since))
                                
                                row.append(s!)
                                
                                //row.append("shit")
                                //row.append(d?.timeIntervalSinceNow)
                                //row.append(v[""].String!)

                                tbody.append(row)

                            }
                            

                        }
                        
                        self.gameInfo = tbody
                        
                        self.gamesCollection.reloadData()
                        
                    }
                    
                }
                
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
                    
                    if status == 404 {
                        
                        self.performSegue(withIdentifier: "gameSettingsSegue",
                                          sender: self)
                        
                    }
                    
                } else {
                    self.performSegue(withIdentifier: "currentGameSegue",
                                      sender: self)
                }
                
        }
        
        
    } // checkActiveGame

    
    // MARK: Actions
    
    @IBAction func newGame(_ sender: Any) {
        checkActiveGame()
    }
    

}

