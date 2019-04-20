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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "結果"
        
        self.loserLabel.text = self.loser
        self.maxScoreLabel.text = self.maxScore
        // Do any additional setup after loading the view.
    }
    
    // Hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.hidesBackButton = true
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
