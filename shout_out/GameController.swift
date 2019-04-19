//
//  GameController.swift
//  shout_out
//
//  Created by Shota Suzuki on 2019/04/17.
//  Copyright © 2019 shiboy_aaashot. All rights reserved.
//

import UIKit
import AudioToolbox

private func AudioQueueInputCallback(
    _ inUserData: UnsafeMutableRawPointer?,
    inAQ: AudioQueueRef,
    inBuffer: AudioQueueBufferRef,
    inStartTime: UnsafePointer<AudioTimeStamp>,
    inNumberPacketDescriptions: UInt32,
    inPacketDescs: UnsafePointer<AudioStreamPacketDescription>?)
{
    // Do nothing, because not recoding.
}

class GameController: UIViewController {
    
    var wordArray: [String] = []
    var memberArray: [String] = []
    
    var round: Int = 1
    var score: Int? = nil
    var border: Int? = nil
    
    var queue: AudioQueueRef!
    var timer: Timer!
    
//    var timer: Timer?
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var memberLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var borderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        drawStartView()
        print("complete drawing view")
        wait( { return self.score == nil } ) {
            // 取得しました
            print("finish")
            //            UIImage(data: imgData as Data)
        }
        self.startUpdatingVolume()
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
    
    func drawStartView() {
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
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.roundLabel.text = String(self.round+1)
//        }
        
    }
    
    func startUpdatingVolume() {
        // Set data format
        var dataFormat = AudioStreamBasicDescription(
            mSampleRate: 44100.0,
            mFormatID: kAudioFormatLinearPCM,
            mFormatFlags: AudioFormatFlags(kLinearPCMFormatFlagIsBigEndian | kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked),
            mBytesPerPacket: 2,
            mFramesPerPacket: 1,
            mBytesPerFrame: 2,
            mChannelsPerFrame: 1,
            mBitsPerChannel: 16,
            mReserved: 0)
        
        // Observe input level
        var audioQueue: AudioQueueRef? = nil
        var error = noErr
        error = AudioQueueNewInput(
            &dataFormat,
            AudioQueueInputCallback,
            UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()),
            .none,
            .none,
            0,
            &audioQueue)
        if error == noErr {
            self.queue = audioQueue
        }
        AudioQueueStart(self.queue, nil)
        
        // Enable level meter
        var enabledLevelMeter: UInt32 = 1
        AudioQueueSetProperty(self.queue, kAudioQueueProperty_EnableLevelMetering, &enabledLevelMeter, UInt32(MemoryLayout<UInt32>.size))
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.5,
                                          target: self,
                                          selector: #selector(GameController.detectVolume(_:)),
                                          userInfo: nil,
                                          repeats: true)
        self.timer?.fire()
    }
    
    func stopUpdatingVolume()
    {
        // Finish observation
        self.timer.invalidate()
        self.timer = nil
        AudioQueueFlush(self.queue)
        AudioQueueStop(self.queue, false)
        AudioQueueDispose(self.queue, true)
    }
    
    @objc func detectVolume(_ timer: Timer)
    {
        // Get level
        var levelMeter = AudioQueueLevelMeterState()
        var propertySize = UInt32(MemoryLayout<AudioQueueLevelMeterState>.size)
        
        AudioQueueGetProperty(
            self.queue,
            kAudioQueueProperty_CurrentLevelMeterDB,
            &levelMeter,
            &propertySize)
        
        // Show the audio channel's peak and average RMS power.
//        self.peakTextField.text = "".appendingFormat("%.2f", levelMeter.mPeakPower)
        print(levelMeter.mPeakPower)
//        self.averageTextField.text = "".appendingFormat("%.2f", levelMeter.mAveragePower)
        print(levelMeter.mAveragePower)
        
        // Show "LOUD!!" if mPeakPower is larger than -1.0
//        self.loudLabel.isHidden = (levelMeter.mPeakPower >= -1.0) ? false : true
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
