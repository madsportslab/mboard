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

class SummaryController: UIViewController {
    
    let defaults = UserDefaults.standard
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadGame()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
            
        } else {
            
            self.aot.text = "\(ot)"
            self.at.text = "\(total)"
            
        }
        
        
        
    } // setScoreboard
    
    
    func loadGame() {
    
        let ed = defaults.object(forKey: Mboard.SERVER) as? String
        let id = defaults.object(forKey: Mboard.GAME) as? String
        
        let url = "\(Mboard.HTTP)\(ed!)/api/scores" + "/\(id!)"
        
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
                        
                        if j["data"]["Valid"].bool! {
                            
                            let data = JSON.parse(j["data"]["String"].string!)
                            
                            self.awayName.text = data["away"]["name"].string!
                            self.homeName.text = data["home"]["name"].string!
                            
                            self.setScoreboard(data["away"]["points"], isHome: false)
                            self.setScoreboard(data["home"]["points"], isHome: true)
                            
                            
                        
                        }
                    
                    }
                    
                }
        }
        
    } // loadGame
    
    // MARK: Actions
    
} // SummaryController
