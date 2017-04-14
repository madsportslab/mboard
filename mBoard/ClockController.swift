//
//  ClockController.swift
//  mBoard
//
//  Created by hu on 4/12/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import AVKit

import Alamofire
import Font_Awesome_Swift
import SwiftWebSocket
import SwiftyJSON

class ClockController: UIViewController {

    var ws = WebSocket()
    
    // MARK: Properties
    @IBOutlet weak var gameClock: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var shotClock: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var rewBtn: UIButton!
    @IBOutlet weak var fwdBtn: UIButton!
    @IBOutlet weak var rewSCBtn: UIButton!
    @IBOutlet weak var fwdSCBtn: UIButton!
    @IBOutlet weak var resetGCBtn: UIButton!
    @IBOutlet weak var resetSCBtn: UIButton!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var shotLabel: UILabel!
    
    override func viewDidDisappear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        
        startBtn.setFAIcon(icon: FAType.FAPlay, iconSize: 96, forState: .normal)
        
        resetGCBtn.setFAIcon(icon: FAType.FARefresh, iconSize: 24, forState: .normal)
        
        rewBtn.setFAIcon(icon: FAType.FABackward, iconSize: 24, forState: .normal)
        fwdBtn.setFAIcon(icon: FAType.FAForward, iconSize: 24, forState: .normal)
        
        rewSCBtn.setFAIcon(icon: FAType.FABackward, iconSize: 24, forState: .normal)
        fwdSCBtn.setFAIcon(icon: FAType.FAForward, iconSize: 24, forState: .normal)
        
        resetSCBtn.setFAIcon(icon: FAType.FARefresh, iconSize: 24, forState: .normal)
        
        
        startBtn.setFATitleColor(color: Mboard.TealColor)
        
        startBtn.layer.borderColor = Mboard.TealColor.cgColor
        startBtn.layer.borderWidth = 1
        startBtn.layer.cornerRadius = 5
        
        rewBtn.layer.borderColor = Mboard.TealColor.cgColor
        rewBtn.layer.borderWidth = 1
        rewBtn.layer.cornerRadius = 5
        
        fwdBtn.layer.borderColor = Mboard.TealColor.cgColor
        fwdBtn.layer.borderWidth = 1
        fwdBtn.layer.cornerRadius = 5
        
        rewSCBtn.layer.borderColor = Mboard.TealColor.cgColor
        rewSCBtn.layer.borderWidth = 1
        rewSCBtn.layer.cornerRadius = 5
        
        fwdSCBtn.layer.borderColor = Mboard.TealColor.cgColor
        fwdSCBtn.layer.borderWidth = 1
        fwdSCBtn.layer.cornerRadius = 5
        
        resetGCBtn.layer.borderColor = UIColor.red.cgColor
        resetGCBtn.layer.borderWidth = 1
        resetGCBtn.layer.cornerRadius = 5
        
        resetSCBtn.layer.borderColor = UIColor.red.cgColor
        resetSCBtn.layer.borderWidth = 1
        resetSCBtn.layer.cornerRadius = 5
        
        loadClock()
        
        initWS()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadClock() {
        
    } // loadClock
    
    
    func initWS() {
        
        
    } // initWS
    
    
    // MARK: Actions
    
    
} // ClockController
