//
//  ViewController.swift
//  shout_out
//
//  Created by 鈴木祥太 on 2019/04/15.
//  Copyright © 2019 shiboy_aaashot. All rights reserved.
//

import UIKit
import AVFoundation

class TitleController: UIViewController {
    
    var wordArray: [String] = []
    var memberArray: [String] = []
    
    var userDefaults = UserDefaults.standard
    
    @IBOutlet weak var gameStartButton: UIButton!
    @IBOutlet weak var wordSettingButton: UIButton!
    @IBOutlet weak var memberSettingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AVCaptureDevice.requestAccess(for: AVMediaType.audio, completionHandler: {(granted: Bool) in })
        
        // Do any additional setup after loading the view.
//        self.userDefaults.removeObject(forKey: "words")
//        self.userDefaults.removeObject(forKey: "members")
        
//        let word1: String = "よっしゃ！"
//        let word2: String = "いぇーい！"
//        let word3: String = "いいね！"
//        self.wordArray.append(word1)
//        self.wordArray.append(word2)
//        self.wordArray.append(word3)
//
//        let member1: String = "たかし"
//        let member2: String = "よしこ"
//        self.memberArray.append(member1)
//        self.memberArray.append(member2)
        
        // 起動時に保存データをロード
        self.userDefaults.register(defaults: ["words": ["ワード1", "ワード2", "ワード3"],
                                              "members": ["メンバー1", "メンバー2", "メンバー3"]])
        self.wordArray = self.userDefaults.array(forKey: "words") as! [String]
        print(self.wordArray)
        self.memberArray = self.userDefaults.array(forKey: "members") as! [String]
        print(self.memberArray)
        
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
//        print("willappear loaded")
//        self.userDefaults.set(self.wordArray, forKey: "words")
//        print("words saved")
//        print(self.userDefaults.array(forKey: "words") as! [String])
//        self.userDefaults.set(self.memberArray, forKey: "members")
//        print("members saved")
//        print(self.userDefaults.array(forKey: "members") as! [String])
    }
    
    @IBAction func playGame(_ sender: Any) {
        if self.wordArray.isEmpty {
            let alert = UIAlertController(title: "エラー", message: "ワードリストが空です", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else if self.memberArray.isEmpty {
            let alert = UIAlertController(title: "エラー", message: "メンバーリストが空です", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            self.performSegue(withIdentifier: "toGameController", sender: nil)
        }
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
    
    @IBAction func backToTitle(segue: UIStoryboardSegue){
        // code
    }
    
}

