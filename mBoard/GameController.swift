//
//  GameController.swift
//  mBoard
//
//  Created by hu on 3/31/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Font_Awesome_Swift

class GameController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var clock: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var shotClock: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var resetClockBtn: UIButton!
    @IBOutlet weak var resetShotClockBtn: UIButton!
    @IBOutlet weak var m1AwayBtn: UIButton!
    @IBOutlet weak var p1AwayBtn: UIButton!
    @IBOutlet weak var m1HomeBtn: UIButton!
    @IBOutlet weak var p1HomeBtn: UIButton!
    @IBOutlet weak var m2AwayBtn: UIButton!
    @IBOutlet weak var p2AwayBtn: UIButton!
    @IBOutlet weak var m2HomeBtn: UIButton!
    @IBOutlet weak var p2HomeBtn: UIButton!
    @IBOutlet weak var m3AwayBtn: UIButton!
    @IBOutlet weak var p3AwayBtn: UIButton!
    @IBOutlet weak var m3HomeBtn: UIButton!
    @IBOutlet weak var p3HomeBtn: UIButton!
    @IBOutlet weak var mFAwayBtn: UIButton!
    @IBOutlet weak var pFAwayBtn: UIButton!
    @IBOutlet weak var mFHomeBtn: UIButton!
    @IBOutlet weak var pFHomeBtn: UIButton!
    @IBOutlet weak var mTAwayBtn: UIButton!
    @IBOutlet weak var pTAwayBtn: UIButton!
    @IBOutlet weak var mTHomeBtn: UIButton!
    @IBOutlet weak var pTHomeBtn: UIButton!
    @IBOutlet weak var rewBtn: UIButton!
    @IBOutlet weak var fwdBtn: UIButton!
    @IBOutlet weak var endBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startBtn.setFAIcon(icon: FAType.FAPlay, iconSize: 16, forState: .normal)
        stopBtn.setFAIcon(icon: FAType.FAPause, iconSize: 16, forState: .normal)
        resetClockBtn.setFAIcon(icon: FAType.FARefresh, iconSize: 16, forState: .normal)
        resetShotClockBtn.setFAIcon(icon: FAType.FARefresh, iconSize: 16, forState: .normal)
        rewBtn.setFAIcon(icon: FAType.FABackward, iconSize: 16, forState: .normal)
        fwdBtn.setFAIcon(icon: FAType.FAForward, iconSize: 16, forState: .normal)
        //endBtn.setFAIcon(icon: FAType.FAStop, iconSize: 16, forState: .normal)
        
        startBtn.layer.borderWidth = 1
        startBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                             blue: 186/255, alpha: 1).cgColor
        
        stopBtn.layer.borderWidth = 1
        stopBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                             blue: 186/255, alpha: 1).cgColor
        
        resetClockBtn.layer.borderWidth = 1
        resetClockBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                             blue: 186/255, alpha: 1).cgColor
        
        resetShotClockBtn.layer.borderWidth = 1
        resetShotClockBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                             blue: 186/255, alpha: 1).cgColor
        
        rewBtn.layer.borderWidth = 1
        rewBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                             blue: 186/255, alpha: 1).cgColor
        
        fwdBtn.layer.borderWidth = 1
        fwdBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                             blue: 186/255, alpha: 1).cgColor
        
        endBtn.layer.borderWidth = 1
        endBtn.layer.borderColor = UIColor(red: 255/255, green: 0/255,
                                             blue: 0/255, alpha: 1).cgColor
        
        m1AwayBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        p1AwayBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        m1HomeBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        p1HomeBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        
        m2AwayBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        p2AwayBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        m2HomeBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        p2HomeBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        
        m3AwayBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        p3AwayBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        m3HomeBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        p3HomeBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        
        mFAwayBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        pFAwayBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        mFHomeBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        pFHomeBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        
        mTAwayBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        pTAwayBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        mTHomeBtn.setFAIcon(icon: FAType.FAMinus, iconSize: 16, forState: .normal)
        pTHomeBtn.setFAIcon(icon: FAType.FAPlus, iconSize: 16, forState: .normal)
        
        
        m1AwayBtn.layer.borderWidth = 1
        m1AwayBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                                      blue: 186/255, alpha: 1).cgColor
        
        m2AwayBtn.layer.borderWidth = 1
        m2AwayBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                                      blue: 186/255, alpha: 1).cgColor
        
        m3AwayBtn.layer.borderWidth = 1
        m3AwayBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                                      blue: 186/255, alpha: 1).cgColor
        
        p1AwayBtn.layer.borderWidth = 1
        p1AwayBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                                      blue: 186/255, alpha: 1).cgColor

        p2AwayBtn.layer.borderWidth = 1
        p2AwayBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                              blue: 186/255, alpha: 1).cgColor
        
        p3AwayBtn.layer.borderWidth = 1
        p3AwayBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                              blue: 186/255, alpha: 1).cgColor
        
        mFAwayBtn.layer.borderWidth = 1
        mFAwayBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                                      blue: 186/255, alpha: 1).cgColor
        
        pFAwayBtn.layer.borderWidth = 1
        pFAwayBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                                      blue: 186/255, alpha: 1).cgColor
        
        mTAwayBtn.layer.borderWidth = 1
        mTAwayBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                                      blue: 186/255, alpha: 1).cgColor
        
        pTAwayBtn.layer.borderWidth = 1
        pTAwayBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                                      blue: 186/255, alpha: 1).cgColor
        
        m1HomeBtn.layer.borderWidth = 1
        m1HomeBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                              blue: 186/255, alpha: 1).cgColor
        
        m2HomeBtn.layer.borderWidth = 1
        m2HomeBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                              blue: 186/255, alpha: 1).cgColor
        
        m3HomeBtn.layer.borderWidth = 1
        m3HomeBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                              blue: 186/255, alpha: 1).cgColor
        
        p1HomeBtn.layer.borderWidth = 1
        p1HomeBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                              blue: 186/255, alpha: 1).cgColor
        
        p2HomeBtn.layer.borderWidth = 1
        p2HomeBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                              blue: 186/255, alpha: 1).cgColor
        
        p3HomeBtn.layer.borderWidth = 1
        p3HomeBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                              blue: 186/255, alpha: 1).cgColor
        
        mFHomeBtn.layer.borderWidth = 1
        mFHomeBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                              blue: 186/255, alpha: 1).cgColor
        
        pFHomeBtn.layer.borderWidth = 1
        pFHomeBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                              blue: 186/255, alpha: 1).cgColor
        
        mTHomeBtn.layer.borderWidth = 1
        mTHomeBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                              blue: 186/255, alpha: 1).cgColor
        
        pTHomeBtn.layer.borderWidth = 1
        pTHomeBtn.layer.borderColor = UIColor(red: 1/255, green: 129/255,
                                              blue: 186/255, alpha: 1).cgColor
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
} // GameController
