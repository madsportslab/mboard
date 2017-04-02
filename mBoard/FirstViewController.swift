//
//  FirstViewController.swift
//  mBoard
//
//  Created by hu on 3/28/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Font_Awesome_Swift

class FirstViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var newGameBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        newGameBtn.layer.borderWidth = 1
        newGameBtn.layer.borderColor = Mboard.TealColor.cgColor
        newGameBtn.layer.cornerRadius = 5
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Actions
    
    @IBAction func newGame(_ sender: Any) {
    }
    

}

