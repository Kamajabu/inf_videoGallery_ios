

import UIKit
import AVFoundation

class PlayerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var shuffle: UISwitch!

    @IBOutlet weak var nextSong: UIBarButtonItem!
    @IBOutlet weak var rewindForward: UIBarButtonItem!
    @IBOutlet weak var previousSong: UIBarButtonItem!
    @IBOutlet weak var rewindBack: UIBarButtonItem!

    @IBOutlet weak var playPause: UIButton!
    var isFirstStart = true

    var imageIndex: IndexPath?
    var musicItems: [MusicItem] = []

    var trackId: Int = 0
    var audioPlayer: AVAudioPlayer!


    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self

        chooseImageTitleArtist(trackId)
        loadMp3(trackId)
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

    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }

    func updateProgressView(){
        if audioPlayer.isPlaying {
            progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: true)
        }
    }

    @IBAction func playAction(_ sender: AnyObject) {
        if !audioPlayer.isPlaying {
            audioPlayer.play()
            if let image = UIImage(named: "pause") {
                UIView.transition(with: playPause, duration: 0.4, options: .transitionFlipFromRight, animations: {
                    sender.setImage(image, for: .normal)
                }, completion: nil)
            }
        } else {
            audioPlayer.pause()
            if let image = UIImage(named:"circled_play") {
                UIView.transition(with: playPause, duration: 0.4, options: .transitionFlipFromRight, animations: {
                    sender.setImage(image, for: .normal)
                }, completion: nil)
            }
        }
    }

    func stopAction(_ sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        progressView.progress = 0
    }

    @IBAction func pauseAction(_ sender: AnyObject) {
        audioPlayer.pause()
    }

    @IBAction func fastForwardAction(_ sender: AnyObject) {
        var time: TimeInterval = audioPlayer.currentTime
        time += 5.0

        if time > audioPlayer.duration {
            stopAction(self)
        }else {
            audioPlayer.currentTime = time
        }

    }

    @IBAction func rewindAction(_ sender: AnyObject) {
        var time: TimeInterval = audioPlayer.currentTime
        time -= 5.0

        if time < 0 {
            stopAction(self)
        }else {
            audioPlayer.currentTime = time
        }
    }


    @IBAction func previousAction(_ sender: AnyObject) {
        if shuffle.isOn {
            trackId = Int(arc4random_uniform(UInt32(musicItems.count)))
        } else if trackId > 0 {
            trackId -= 1
        } else {
            trackId = 11
        }

        audioPlayer.currentTime = 0
        progressView.progress = 0

        chooseImageTitleArtist(trackId)
        loadMp3(trackId)
    }

    @IBAction func nextAction(_ sender: AnyObject) {

        if shuffle.isOn {
            trackId = Int(arc4random_uniform(UInt32(musicItems.count)))
        } else if trackId < (musicItems.count - 1) {
            trackId += 1
        } else {
            trackId = 0
        }

        audioPlayer.currentTime = 0
        progressView.progress = 0

        chooseImageTitleArtist(trackId)
        loadMp3(trackId)

    }

    func chooseImageTitleArtist(_ trackId: Int) {
        self.collectionView?.scrollToItem(at: IndexPath(item: trackId, section: 0),
                                          at: .centeredHorizontally, animated: true)
        self.collectionView.reloadData()

        songTitleLabel.text = musicItems[trackId].title
        artistLabel.text = musicItems[trackId].artist
    }


    func loadMp3(_ trackId: Int) {
        let path = Bundle.main.path(forResource: "\(musicItems[trackId].fileName)", ofType: "mp3")

        if let path = path {
            let mp3URL = URL(fileURLWithPath: path)

            do {
                audioPlayer = try AVAudioPlayer(contentsOf: mp3URL)
                audioPlayer.play()

                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PlayerViewController.updateProgressView), userInfo: nil, repeats: true)
                progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }

    }
}
