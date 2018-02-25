//
//  SelectMboardController.swift
//  mBoard
//
//  Created by hu on 7/7/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

import Font_Awesome_Swift

class SelectMboardController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let defaults = UserDefaults.standard
    var servers = [String]()
    var saved = [String]()
    
    // MARK: Properties
    @IBOutlet weak var boards: UITableView!
    @IBOutlet weak var addDevice: UIBarButtonItem!
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.boards.delegate = self
        self.boards.dataSource = self
        
        if let s = defaults.object(forKey: Mboard.SAVED_SERVERS) as? [String] {
            self.servers = s
        }
        
        addDevice.setFAIcon(icon: FAType.FAPlus, iconSize: 24)
        
        
        self.boards.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.boards.dequeueReusableCell(withIdentifier: "cell",
            for: indexPath) as! ServerViewCell
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = Mboard.TealColor
        cell.selectedBackgroundView = bgColorView
        
        cell.board.text = servers[indexPath.item]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        defaults.set(servers[indexPath.item], forKey: Mboard.SERVER)
        self.performSegue(withIdentifier: "homeSegue", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
        }
        
    }

    
    // MARK: Actions
    
} // SelectMboardController
