//
//  GameController.swift
//  shout_out
//
//  Created by Shota Suzuki on 2019/04/17.
//  Copyright © 2019 shiboy_aaashot. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    var wordArray: [String] = []
    var memberArray: [String] = []
    
    var round: Int = 1
    var score: Int? = nil
    var border: Int? = nil
    
    var timer: Timer?
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var memberLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var borderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playGame()
    }
    
    // Hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func recordVoice(_ sender: Any) {
//        self.was_record = true
        DispatchQueue.global().async {
            self.score = 1
        }
//        self.timer?.invalidate()
    }
    
//    @objc func timerUpdate() {
//        print("update")
//    }'
    
    func wait(_ waitContinuation: @escaping (()->Bool), compleation: @escaping (()->Void)) {
        var wait = waitContinuation()
        // 0.01秒周期で待機条件をクリアするまで待ちます。
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().async {
            while wait {
                DispatchQueue.main.async {
                    wait = waitContinuation()
                    semaphore.signal()
                }
                semaphore.wait()
                Thread.sleep(forTimeInterval: 0.01)
            }
            // 待機条件をクリアしたので通過後の処理を行います。
            DispatchQueue.main.async {
                compleation()
            }
        }
    }
    
    func playGame() {
        self.roundLabel.text = String(self.round)
        
        let memberIndex: Int = Int(arc4random_uniform(UInt32(self.memberArray.count)))
        self.memberLabel.text = String(memberArray[memberIndex])
        
        let wordIndex: Int = Int(arc4random_uniform(UInt32(self.wordArray.count)))
        self.wordLabel.text = String(wordArray[wordIndex])
        
//        while !self.was_record {
//
//        }
//        self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(GameController.timerUpdate), userInfo: nil, repeats: true)
//        RunLoop.main.add(self.timer!, forMode: RunLoop.Mode.default)
        wait( { return self.score == nil } ) {
            // 取得しました
            print("finish")
//            UIImage(data: imgData as Data)
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.roundLabel.text = String(self.round+1)
//        }
        
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
