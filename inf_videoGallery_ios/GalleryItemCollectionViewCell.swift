//
//  GalleryItemCollectionViewCell.swift
//  UICollectionView_p1_Swift
//
//  Created by Kamil Buczel on 29.03.2017.
//  Copyright © 2017 Kamajabu. All rights reserved.
//

import UIKit
import AVFoundation

class GalleryItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIImageView!
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        
        playerItem = AVPlayerItem(url: url! as URL)
        player = AVPlayer(playerItem: playerItem!)
        playerLayer = AVPlayerLayer(player: player!)
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
