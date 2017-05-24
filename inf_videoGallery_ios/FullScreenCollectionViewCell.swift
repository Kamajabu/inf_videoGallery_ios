//
//  CollectionViewCell.swift
//  Example
//
//  Created by Benjamin Emdon on 2016-12-28.
//  Copyright © 2016 Benjamin Emdon.
//

import UIKit
import AVFoundation

class FullScreenCollectionViewCell: UICollectionViewCell {

    var index = 0
    var isPlaying = false

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //set variables for video play
    var playerItem:AVPlayerItem?
    var player: AVPlayer?
    var playerLayer = AVPlayerLayer()

    var timeWatcher : AnyObject!

    var timeRemainingLabel = UILabel()

    let seekSlider = UISlider()
    var playerRateBeforeSeek : Float = 0

    var isPlayerCreated = false

    @IBOutlet weak var containerView: UIView!

    var createLayerSwitch = true
    
    func closePlayer(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        if (createLayerSwitch == false) {
            if let _ = player {
                player!.pause()
            }
            player = nil
            playerLayer.removeFromSuperlayer()
        }
    }

    func showVideo(_ videoAddress: String) {
        let url = NSURL(string: videoAddress)

        playerItem = AVPlayerItem(url: url as! URL)
        player = AVPlayer(playerItem: playerItem!)
        playerLayer = AVPlayerLayer(player: player!)

        playerLayer.frame = containerView.bounds

        containerView.layer.addSublayer(playerLayer)

        player!.play()
        isPlaying = true

        let timeInterval : CMTime = CMTimeMakeWithSeconds(1.0, 10)
        timeWatcher = player!.addPeriodicTimeObserver(forInterval: timeInterval, queue: DispatchQueue.main, using: { [weak self] time in
         self?.handlePlayerStatus(time: time)
        }) as AnyObject!


        createLayerSwitch = false
    }

    func handlePlayerStatus(time: CMTime) {
        print("the time has now been:", CMTimeGetSeconds(time))

        if player?.status == .readyToPlay {
            activityIndicator.isHidden = true
            // buffering is finished, the player is ready to play
            print("playing")
        }
        if player?.status == .unknown{
            activityIndicator.isHidden = false
            print("Buffering")
        }
    }

    func pauseVideo() {
        if let currentPlayer = player {
        currentPlayer.pause()
        isPlaying = false
        }
    }

    func resumeVideo() {
        if let currentPlayer = player {
        currentPlayer.play()
        isPlaying = true
        }
    }
}

