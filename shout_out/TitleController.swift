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
    
    @IBOutlet weak var gameStartButton: UIButton!
    @IBOutlet weak var wordSettingButton: UIButton!
    @IBOutlet weak var memberSettingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let word1: String = "よっしゃ！"
        let word2: String = "いぇーい！"
        let word3: String = "いいね！"
        self.wordArray.append(word1)
        self.wordArray.append(word2)
        self.wordArray.append(word3)
        
        let member1: String = "たかし"
        let member2: String = "よしこ"
        self.memberArray.append(member1)
        self.memberArray.append(member2)
        
        self.gameStartButton.layer.borderWidth = 1.0
        self.gameStartButton.layer.borderColor = UIColor.white.cgColor
        self.gameStartButton.layer.cornerRadius = 5.0
        
        self.wordSettingButton.layer.borderWidth = 1.0
        self.wordSettingButton.layer.borderColor = UIColor.white.cgColor
        self.wordSettingButton.layer.cornerRadius = 5.0
        
        self.memberSettingButton.layer.borderWidth = 1.0
        self.memberSettingButton.layer.borderColor = UIColor.white.cgColor
        self.memberSettingButton.layer.cornerRadius = 5.0
    }
    
    // Hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toWordSettingController" {
            //            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let wordSettingController:WordSettingController = segue.destination as! WordSettingController
            wordSettingController.wordArray = self.wordArray
        } else if segue.identifier == "toMemberSettingController" {
            let memberSettingController:MemberSettingController = segue.destination as! MemberSettingController
            memberSettingController.memberArray = self.memberArray
        } else if segue.identifier == "toGameController" {
            let gameController:GameController = segue.destination as! GameController
            gameController.wordArray = self.wordArray
            gameController.memberArray = self.memberArray
        }
        
    }
    
    
    
}

