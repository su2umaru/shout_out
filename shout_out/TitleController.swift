//
//  ViewController.swift
//  shout_out
//
//  Created by 鈴木祥太 on 2019/04/15.
//  Copyright © 2019 shiboy_aaashot. All rights reserved.
//

import UIKit

class TitleController: UIViewController {
    
    var wordArray: [String] = []
    var memberArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //        let word1: String = "よっしゃ！"
        //        let word2: String = "いぇーい！"
        //        let word3: String = "いいね！"
        //
        //        wordArray.append(word1)
        //        wordArray.append(word2)
        //        wordArray.append(word3)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toWordSettingController" {
            //            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let wordSettingController:WordSettingController = segue.destination as! WordSettingController
            wordSettingController.wordArray = self.wordArray
        } else if segue.identifier == "toMemberSettingController" {
            let memberSettingController:MemberSettingController = segue.destination as! MemberSettingController
            memberSettingController.memberArray = self.memberArray
        }
        
    }
    
    
    
}

