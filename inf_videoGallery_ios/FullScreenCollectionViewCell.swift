//
//  CollectionViewCell.swift
//  Example
//
//  Created by Benjamin Emdon on 2016-12-28.
//  Copyright © 2016 Benjamin Emdon.
//

import UIKit
import AVFoundation

protocol CollectionViewCellDelegate: class {
    func cellDelegateCloseController(sender: AnyObject)
}
class FullScreenCollectionViewCell: UICollectionViewCell {


    let avPlayer = AVPlayer()
    var avPlayerLayer: AVPlayerLayer!

    let playerButton = UIButton()

    var timeWatcher : AnyObject!

    var timeRemainingLabel = UILabel()

    let seekSlider = UISlider()
    var playerRateBeforeSeek : Float = 0

    @IBOutlet weak var containerView: UIView!
    weak var closeDelegate: CollectionViewCellDelegate?


    func setGalleryItem(_ item:MusicItem) {
//        itemImage.image = UIImage(named: item.itemImage)
    }

    func stopPlayer() {
        avPlayer.pause()
    }

    func loadPlayer() {
        containerView.backgroundColor = .black

//        var view = UIView(frame: CGRectMake(0, 0, containerView.width, containerView.height))


        // An AVPlayerLayer is a CALayer instance to which the AVPlayer can
        // direct its visual output. Without it, the user will see nothing.
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        containerView.layer.insertSublayer(avPlayerLayer, at: 0)
        avPlayerLayer.frame = containerView.bounds


        //this is for the button, we will do it through storyboard
        containerView.addSubview(playerButton)
        playerButton.addTarget(containerView, action: #selector(playerButtonTapped), for: .touchUpInside)


        let url = NSURL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")

//        var asset = AVAsset(url: url as! URL)
//        var imageGenerator = AVAssetImageGenerator(asset: asset)
//        var time = CMTimeMake(1, 1)
//
//        var imageRef = try! imageGenerator.copyCGImage(at: time, actualTime: nil)
//        var thumbnail = UIImage(cgImage:imageRef)
//
//        self.containerView.backgroundColor = UIColor(patternImage: thumbnail)


        let playerItem = AVPlayerItem(url: url! as URL)
        avPlayer.replaceCurrentItem(with: playerItem)
        avPlayer.play()

        //timer info
        let timeInterval : CMTime = CMTimeMakeWithSeconds(1.0, 10)
        timeWatcher = avPlayer.addPeriodicTimeObserver(forInterval: timeInterval,
                                                       queue: DispatchQueue.main, using: { [weak self] time in
                                                        self?.handlePlayerStatus(time: time)


        }) as AnyObject!
//            // print("the time has now been:", CMTimeGetSeconds(elapsedTime))
////            self.containerView.observeTime(elapsedTime: elapsedTime)
//            self.timeRemainingLabel.textColor = .white
//            self.containerView.addSubview(self.timeRemainingLabel)
//
//            //buffer indicator
////            self.loadingIndicatorView.hidesWhenStopped = true
////            self.view.addSubview(self.loadingIndicatorView)
////            self.avPlayer.addObserver(self, forKeyPath: "currentItem.playbackLikelyToKeepUp", options: .new, context: &playbackLikelyToKeepUpContext)
//
//        }) as AnyObject!
    }

    func handlePlayerStatus(time: CMTime) {
        print("the time has now been:", CMTimeGetSeconds(time))

        if avPlayer.status == .readyToPlay {
            // buffering is finished, the player is ready to play
            print("playing")
        }
        if avPlayer.status == .unknown{
            print("Buffering")
        }
    }


    func playerButtonTapped() {
        print("tapped")
    }
}

