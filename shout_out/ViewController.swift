//
//  ViewController.swift
//  shout_out
//
//  Created by 鈴木祥太 on 2019/04/15.
//  Copyright © 2019 shiboy_aaashot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    class Item{
        var name : String
        
        init(name: String) {
            self.name = name
        }
    }
    
    var wordArray: [Item] = []
    var memberArray: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toWordSettingController" {
            let wordSettingController:WordSettingController = segue.destination as! WordSettingController
            
            wordSettingController.wordArray = self.wordArray
        }
        
    }


}

