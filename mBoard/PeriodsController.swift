//
//  PeriodsController.swift
//  mBoard
//
//  Created by hu on 4/1/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Font_Awesome_Swift

class PeriodsController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var p2: UILabel!
    @IBOutlet weak var p4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        p4.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                     size: 14)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Actions
    
} // PeriodsController
