//
//  GameTabBarController.swift
//  mBoard
//
//  Created by hu on 4/1/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Font_Awesome_Swift

class GameTabBarController: UITabBarController {
    
    // MARK: Properties
    @IBOutlet weak var tabs: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tabs.items?[0].setFAIcon(icon: FAType.FASoccerBallO, size: nil, textColor: UIColor.lightGray, backgroundColor: UIColor.clear, selectedTextColor: Mboard.TealColor, selectedBackgroundColor: UIColor.clear)
        tabs.items?[1].setFAIcon(icon: FAType.FAClockO, size: nil, textColor: UIColor.lightGray, backgroundColor: UIColor.clear, selectedTextColor: Mboard.TealColor, selectedBackgroundColor: UIColor.clear)
        tabs.items?[2].setFAIcon(icon: FAType.FAList, size: nil, textColor: UIColor.lightGray, backgroundColor: UIColor.clear, selectedTextColor: Mboard.TealColor, selectedBackgroundColor: UIColor.clear)
        tabs.items?[3].setFAIcon(icon: FAType.FAVideoCamera, size: nil, textColor: UIColor.lightGray, backgroundColor: UIColor.clear, selectedTextColor: Mboard.TealColor, selectedBackgroundColor: UIColor.clear)
        tabs.items?[4].setFAIcon(icon: FAType.FACog, size: nil, textColor: UIColor.lightGray, backgroundColor: UIColor.clear, selectedTextColor: Mboard.TealColor, selectedBackgroundColor: UIColor.clear)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
} // GameTabBarController
