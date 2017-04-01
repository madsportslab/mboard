//
//  FoulsController.swift
//  mBoard
//
//  Created by hu on 4/1/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Font_Awesome_Swift

class FoulsController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var f0: UILabel!
    @IBOutlet weak var f5: UILabel!
    @IBOutlet weak var f10: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        f0.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "\t",
                     size: 14)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
} // FoulsController
