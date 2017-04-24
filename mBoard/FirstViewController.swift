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

    let defaults = UserDefaults.standard
    let gameInfo = [[String]]()
    
    // MARK: Properties
    @IBOutlet weak var newGameBtn: UIButton!
    @IBOutlet weak var gamesTable: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //newGameBtn.layer.borderWidth = 1
        //newGameBtn.layer.borderColor = Mboard.TealColor.cgColor
        //newGameBtn.layer.cornerRadius = 15

        getScores()

        newGameBtn.setFAIcon(icon: FAType.FASoccerBallO, iconSize: 72, forState: .normal)
        newGameBtn.setFATitleColor(color: UIColor.white)
        
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
        
        let cell = gamesTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameViewCell
        
        
        cell.title.text = gameInfo[indexPath.item][0]
        cell.status.text = gameInfo[indexPath.item][1]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func getScores() {
        
        let ed = defaults.object(forKey: Mboard.SERVER) as? String
        
        let url = "\(Mboard.HTTP)\(ed!)/api/scores"
        
        Alamofire.request(url, method: .get)
            .responseJSON{ response in
                
                switch response.result {
                case .failure(let error):
                    
                    print("buttfuck")
                    
                    
                case .success:
                    
                    if let raw = response.result.value {
                        
                        let j = JSON(raw)
                        
                        print(j)
                        
                        var tbody = [[String]]()
                        
                        
                        if j["status"].int == 1 {

                            print("fucking her")
                            
                            let data = JSON.parse(j["data"].string!)

                            print(data)
                            
                            for (_,v) in data {
                                
                                print(v)
                                
                                var row = [String]()
                                
                                row.append("testing")
                                row.append("Final")
                                
                                tbody.append(row)

                            }

                            
                        } else {
                            print("fuck you")
                        }
                        
                        
                    }
                    
                }
                
        }
        
        
    } // getScores
    
    func checkActiveGame() {
        
        let ed = defaults.object(forKey: Mboard.SERVER) as? String
        
        let url = "\(Mboard.HTTP)\(ed!)/api/games"
        
        Alamofire.request(url, method: .get)
            .response{ response in
                
                print("FAGGOT")

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
                        
                        print("fag")
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

