

import UIKit
import AVFoundation

struct ChangeVideoNotifications {
    static let videoChanged = Notification.Name("videoChangedNotification")
    static let periodicUpdate = Notification.Name("periodicUpdate")
}

class PlayerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var shuffle: UISwitch!
    
    @IBOutlet weak var nextSong: UIBarButtonItem!
    @IBOutlet weak var rewindForward: UIBarButtonItem!
    @IBOutlet weak var previousSong: UIBarButtonItem!
    @IBOutlet weak var rewindBack: UIBarButtonItem!
    
    @IBOutlet weak var playPause: UIButton!
    
    var currentCell: FullScreenCollectionViewCell!
    
    var isFirstStart = true
    var lastVisibleCellNumber: Int!
    
    var imageIndex: IndexPath?
    var musicItems: [MusicItem] = []
    
    let durationOfAnimation = 0.4
    
    var trackId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        chooseImageTitleArtist(trackId)
        registerChangedVideoNotification() 
    }
    
    override func viewDidLayoutSubviews() {
        if (isFirstStart) {
            self.collectionView?.scrollToItem(at: imageIndex!, at: .centeredHorizontally, animated: false)
            self.collectionView.reloadData()
            isFirstStart = false
        }
        
    }
    
    @IBAction func backButtonDidTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playAction(_ sender: AnyObject) {
        if !currentCell.isPlaying {
            currentCell.resumeVideo()
            animateButtonToPauseIcon(sender)
        } else {
            currentCell.pauseVideo()
            animateButtonToPlayIcon(sender)
        }
    }
    
    func animateButtonToPlayIcon(_ sender: AnyObject) {
        if let image = UIImage(named:"circled_play") {
            UIView.transition(with: playPause, duration: durationOfAnimation,
                              options: .transitionFlipFromRight, animations: {
                                sender.setImage(image, for: .normal)
            }, completion: nil)
        }
    }
    
    func animateButtonToPauseIcon(_ sender: AnyObject) {
        if let image = UIImage(named: "pause") {
            UIView.transition(with: playPause, duration: durationOfAnimation,
                              options: .transitionFlipFromRight, animations: {
                                sender.setImage(image, for: .normal)
            }, completion: nil)
        }
    }
    
    fileprivate func registerChangedVideoNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didReceiveChangeVideoNotification),
                                               name: ChangeVideoNotifications.videoChanged,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateVideoPlayerSlider),
                                               name: ChangeVideoNotifications.periodicUpdate,
                                               object: nil)
    }
    
    @objc func didReceiveChangeVideoNotification(){
        if !currentCell.isPlaying {
            animateButtonToPlayIcon(playPause)
        } else {
            animateButtonToPauseIcon(playPause)
        }
    }
    
    //There are a lot of magic numbers, if it would be comercial app they should be refactored.
    //Same as methods lengths, app architecture, putting logic to IBAction etc.
    
    @objc func updateVideoPlayerSlider() {
        let currentTimeInSeconds = CMTimeGetSeconds((currentCell.player?.currentTime())!)
        
        let mins = currentTimeInSeconds / 60
        let secs = currentTimeInSeconds.truncatingRemainder(dividingBy: 60)
        let timeformatter = NumberFormatter()
        timeformatter.minimumIntegerDigits = 2
        timeformatter.minimumFractionDigits = 0
        timeformatter.roundingMode = .down
        guard let _ = timeformatter.string(from: NSNumber(value: mins)),
            let _ = timeformatter.string(from: NSNumber(value: secs)) else {
                return
        }
        progressSlider.value = Float(currentTimeInSeconds)
        
        if let currentItem = currentCell.player?.currentItem {
            let duration = currentItem.duration
            if (CMTIME_IS_INVALID(duration)) {
                return;
            }
            let currentTime = currentItem.currentTime()
            progressSlider.value = Float(CMTimeGetSeconds(currentTime) / CMTimeGetSeconds(duration))
        }
    }
    
    func stopAction(_ sender: AnyObject) {
        progressSlider.value = 0
    }
    
    @IBAction func pauseAction(_ sender: AnyObject) {
    }
    
    @IBAction func fastForwardAction(_ sender: AnyObject) {
    }
    
    @IBAction func rewindAction(_ sender: AnyObject) {
    }
    
    @IBAction func previousAction(_ sender: AnyObject) {
        if shuffle.isOn {
            trackId = Int(arc4random_uniform(UInt32(musicItems.count)))
        } else if trackId > 0 {
            trackId -= 1
        } else {
            trackId = 11
        }
        
        progressSlider.value = 0
        
        chooseImageTitleArtist(trackId)    }
    
    @IBAction func nextAction(_ sender: AnyObject) {
        if shuffle.isOn {
            trackId = Int(arc4random_uniform(UInt32(musicItems.count)))
        } else if trackId < (musicItems.count - 1) {
            trackId += 1
        } else {
            trackId = 0
        }
        
        progressSlider.value = 0
        chooseImageTitleArtist(trackId)
    }
    
    func chooseImageTitleArtist(_ trackId: Int) {
        self.collectionView?.scrollToItem(at: IndexPath(item: trackId, section: 0),
                                          at: .centeredHorizontally, animated: true)
        self.collectionView.reloadData()
        
        songTitleLabel.text = musicItems[trackId].title
        artistLabel.text = musicItems[trackId].artist
    }
    
    
}
