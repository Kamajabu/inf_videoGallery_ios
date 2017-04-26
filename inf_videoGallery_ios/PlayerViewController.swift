

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

    var lastVisibleCellNumber: Int!
    var previousCell: FullScreenCollectionViewCell!

    var imageIndex: IndexPath?
    var musicItems: [MusicItem] = []

    var trackId: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self

        chooseImageTitleArtist(trackId)
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
    }


    @IBAction func playAction(_ sender: AnyObject) {

    }

    func stopAction(_ sender: AnyObject) {

        progressView.progress = 0
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

        progressView.progress = 0

        chooseImageTitleArtist(trackId)    }

    @IBAction func nextAction(_ sender: AnyObject) {

        if shuffle.isOn {
            trackId = Int(arc4random_uniform(UInt32(musicItems.count)))
        } else if trackId < (musicItems.count - 1) {
            trackId += 1
        } else {
            trackId = 0
        }

        progressView.progress = 0

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
