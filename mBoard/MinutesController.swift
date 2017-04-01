//
//  MinutesController.swift
//  mBoard
//
//  Created by hu on 4/1/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Font_Awesome_Swift

class MinutesController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var m5: UILabel!
    @IBOutlet weak var m8: UILabel!
    @IBOutlet weak var m10: UILabel!
    @IBOutlet weak var m12: UILabel!
    @IBOutlet weak var m15: UILabel!
    @IBOutlet weak var m20: UILabel!
    @IBOutlet weak var m30: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        m12.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                      size: 14, iconSize: 16)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
} // MinutesController
