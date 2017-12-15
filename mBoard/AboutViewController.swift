//
//  AboutViewController.swift
//  mBoard
//
//  Created by hu on 3/30/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Alamofire
import Font_Awesome_Swift
import SwiftyJSON

class AboutViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    var server:String?
    
    // MARK: Properties
    @IBOutlet weak var checkBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //aboutLabel.text = "Take your sporting events to the next level with mboard, the digital scoreboard.  mboard brings a modern, digital experience to sports providing real time data, rich media, in-game analyses, and much more.  Created by madsportslab whose mission is to bring the best experiences for all sports.  We are sports enthusiasts and technology experts, welcome to the next generation of sports."
        
        server = (defaults.object(forKey: Mboard.SERVER) as? String)!
        
        checkBtn.layer.borderWidth = 1
        checkBtn.layer.borderColor = Mboard.TealColor.cgColor
        checkBtn.layer.backgroundColor = UIColor.clear.cgColor
        checkBtn.layer.cornerRadius = 5
        
        //getFirmware()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
}
