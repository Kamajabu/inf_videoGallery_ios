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
    
    //set variables for video play
    var playerItem:AVPlayerItem?
    var player:AVPlayer?
    var playerLayer = AVPlayerLayer()  //NEW playerLayer var location

    var timeWatcher : AnyObject!

    var timeRemainingLabel = UILabel()

    let seekSlider = UISlider()
    var playerRateBeforeSeek : Float = 0

    var isPlayerCreated = false

    @IBOutlet weak var containerView: UIView!

    var createLayerSwitch = true
    func closePlayer(){
        if (createLayerSwitch == false) {
            player!.pause()
            player = nil
            playerLayer.removeFromSuperlayer()
//            containerView.layer.removeFromSuperlayer()
//            playerLayer.removefromsuperlayer()
        }
    }

    func showVideo(_ videoAddress: String) {
        let url = NSURL(string: videoAddress)

        playerItem = AVPlayerItem(url: url as! URL)
        player = AVPlayer(playerItem: playerItem!)
        playerLayer = AVPlayerLayer(player: player!) //NEW: remove 'let' from playeLayer here.


        containerView.backgroundColor = .black

        containerView.layer.addSublayer(playerLayer)
        playerLayer.frame = containerView.bounds

        player!.play()

        createLayerSwitch = false
    }
}


        //this is for the button, we will do it through storyboard
//        containerView.addSubview(playerButton)
//        playerButton.addTarget(containerView, action: #selector(playerButtonTapped), for: .touchUpInside)



        //        var asset = AVAsset(url: url as! URL)
        //        var imageGenerator = AVAssetImageGenerator(asset: asset)
        //        var time = CMTimeMake(1, 1)
        //
        //        var imageRef = try! imageGenerator.copyCGImage(at: time, actualTime: nil)
        //        var thumbnail = UIImage(cgImage:imageRef)
        //
        //        self.containerView.backgroundColor = UIColor(patternImage: thumbnail)


//        let playerItem = AVPlayerItem(url: url! as URL)
//        avPlayer.replaceCurrentItem(with: playerItem)

    

//
//    func createPlayer() {
//
//        //timer info
//        let timeInterval : CMTime = CMTimeMakeWithSeconds(1.0, 10)
//        timeWatcher = avPlayer.addPeriodicTimeObserver(forInterval: timeInterval,
//                                                       queue: DispatchQueue.main, using: { [weak self] time in
//                                                        self?.handlePlayerStatus(time: time)
//
//
//        }) as AnyObject!
//        //            // print("the time has now been:", CMTimeGetSeconds(elapsedTime))
//        ////            self.containerView.observeTime(elapsedTime: elapsedTime)
//        //            self.timeRemainingLabel.textColor = .white
//        //            self.containerView.addSubview(self.timeRemainingLabel)
//        //
//        //            //buffer indicator
//        ////            self.loadingIndicatorView.hidesWhenStopped = true
//        ////            self.view.addSubview(self.loadingIndicatorView)
//        ////            self.avPlayer.addObserver(self, forKeyPath: "currentItem.playbackLikelyToKeepUp", options: .new, context: &playbackLikelyToKeepUpContext)
//        //
//        //        }) as AnyObject!
//    }
//
//    func stopPlayer() {
////        avPlayer.removeTimeObserver(timeWatcher)
//        avPlayer.pause()
////        avPlayer.removeTimeObserver(timeWatcher)
////        avPlayer = nil
//    }
//
//    func loadPlayer(_ videoAddress: String) {
////        if(avPlayer == nil) {
//            self.initPlayer(videoAddress)
////        }
//        avPlayer.play()
//
//    }
//
//    func handlePlayerStatus(time: CMTime) {
//        print("the time has now been:", CMTimeGetSeconds(time))
//
//        if avPlayer.status == .readyToPlay {
//            // buffering is finished, the player is ready to play
//            print("playing")
//        }
//        if avPlayer.status == .unknown{
//            print("Buffering")
//        }
//    }

