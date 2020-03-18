//
//  homePagePlayVideoViewController.swift
//  MySociety
//
//  Created by Admin on 03/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import AVKit

class homePagePlayVideoViewController: UIViewController {

    var state: Int = 1 //0: Play, 1: Pause
    var player: AVPlayer?
    var videoUrl = ""
    
    
    @IBOutlet weak var videoProgressBar: UIProgressView!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBAction func playButtonAction(_ sender: UIButton) {
        if state != 0{
            state = 0
            player?.play()
        }
    }
    @IBAction func pauseButtonAction(_ sender: UIButton) {
        if state != 1{
            state = 1
            player?.pause()
        }
    }
    
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBAction func rewindAction(_ sender: UIButton) {
        
    }
    @IBAction func forwardAction(_ sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.tabBar.isHidden = true
        playButton.cornerRadius(radius: 10.0)
        pauseButton.cornerRadius(radius: 10.0)
        rewindButton.isHidden = true
        forwardButton.isHidden = true
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "timeControlStatus", let change = change, let newValue = change[NSKeyValueChangeKey.newKey] as? Int, let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
            let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
            let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
            if newStatus != oldStatus {
                DispatchQueue.main.async {[weak self] in
                    if newStatus == .playing || newStatus == .paused {
                        self?.loaderView.isHidden = true
                        self?.rewindButton.isHidden = false
                        self?.forwardButton.isHidden = false
                    } else {
                        self?.loaderView.isHidden = false
                        self?.rewindButton.isHidden = true
                        self?.forwardButton.isHidden = true
                    }
                }
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        let videoURL = URL(string: "\(self.videoUrl)")
        player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.videoView.bounds
        self.videoView.layer.addSublayer(playerLayer)
        player?.play()
        player?.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
        state = 0
    }
    
    func rewindVideo(by seconds: Float64) {
        if let currentTime = player?.currentTime() {
            var newTime = CMTimeGetSeconds(currentTime) - seconds
            if newTime <= 0 {
                newTime = 0
            }
            player?.seek(to: CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000))
        }
    }

    func forwardVideo(by seconds: Float64) {
        if let currentTime = player?.currentTime(), let duration = player?.currentItem?.duration {
            var newTime = CMTimeGetSeconds(currentTime) + seconds
            if newTime >= CMTimeGetSeconds(duration) {
                newTime = CMTimeGetSeconds(duration)
            }
            player?.seek(to: CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000))
        }
    }
}
