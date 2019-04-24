//
//  ResultController.swift
//  shout_out
//
//  Created by 鈴木祥太 on 2019/04/20.
//  Copyright © 2019 shiboy_aaashot. All rights reserved.
//

import UIKit

class ResultController: UIViewController {
    
    var loser:String = ""
    var maxScore:String = ""
    
    @IBOutlet weak var loserLabel: UILabel!
    @IBOutlet weak var maxScoreLabel: UILabel!
    @IBOutlet weak var backTitleButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loserLabel.text = self.loser
        self.loserLabel.text?.append("の負け")
//        self.loserLabel.text = self.loser
        self.maxScoreLabel.text = "最大スコア "
        self.maxScoreLabel.text?.append(self.maxScore.replacingOccurrences(of: "ボーダー ", with: "").replacingOccurrences(of: " を超えろ！", with: ""))
        
        self.backTitleButton.layer.borderWidth = 1.0
        self.backTitleButton.layer.borderColor = UIColor.white.cgColor
        self.backTitleButton.layer.cornerRadius = 5.0
        
//        self.maxScoreLabel.text = self.maxScore
        // Do any additional setup after loading the view.
    }
    
    // Hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func backTitle(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
//        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
