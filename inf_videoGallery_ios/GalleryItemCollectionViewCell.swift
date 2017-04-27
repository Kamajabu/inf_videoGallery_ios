//
//  GalleryItemCollectionViewCell.swift
//  UICollectionView_p1_Swift
//
//  Created by olxios on 20/11/14.
//  Copyright (c) 2014 olxios. All rights reserved.
//

import UIKit
import AVFoundation

class GalleryItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIImageView!
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //set variables for video play
    var playerItem:AVPlayerItem?
    var player:AVPlayer?
    var playerLayer = AVPlayerLayer()

    var timeWatcher : AnyObject!

    func setGalleryItem(_ item:UIImage) {

            itemImageView.image = item

    }

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


        //        containerView.backgroundColor = .black
        playerLayer.frame = containerView.bounds

        containerView.layer.addSublayer(playerLayer)

        player!.play()

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
    
}
