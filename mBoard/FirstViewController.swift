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

class FirstViewController: UIViewController {

    var ws = WebSocket()
    
    // MARK: Properties
    @IBOutlet weak var newGameBtn: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        newGameBtn.layer.borderWidth = 1
        newGameBtn.layer.borderColor = Mboard.TealColor.cgColor
        newGameBtn.layer.cornerRadius = 15
        
        print(defaults.object(forKey: Mboard.SERVER) as? String)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openWS() {
    
        
    } // openWS
    
    func getScores() {
        
        /*let params = ["home": "what"]
        
        Alamofire.request(Mboard.GAMES, method: .post, parameters: params)
            .responseJSON{ response in
                
                switch response.result {
                case .failure(let error):
                    print(error)
                case .success:
                    print("ok")
                }
                
        }
        */
        
    } // getScores
    
    // MARK: Actions
    
    @IBAction func newGame(_ sender: Any) {
    }
    

}

