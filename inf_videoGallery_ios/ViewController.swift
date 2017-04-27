//
//  ViewController.swift
//  UICollectionView_p1_Swift
//
//  Created by olxios on 20/11/14.
//  Copyright (c) 2014 olxios. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    

    @IBOutlet var collectionView: UICollectionView!

    var musicItems: [MusicItem] = []
    var galleryItems: [UIImage] = []

    var selectedItem: IndexPath?
    
    // MARK: -
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initGalleryItems()
        downloadGalleryItems()

        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.collectionView.addGestureRecognizer(lpgr)
    }

    func downloadGalleryItems(){
        for item in musicItems {
        do {
            let url = NSURL(string: item.videoAddress)
            let asset = AVURLAsset(url: url as! URL, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(5, 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)

            galleryItems.append(thumbnail)
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()

    NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    fileprivate func initGalleryItems() {
        
        var items = [MusicItem]()
        let inputFile = Bundle.main.path(forResource: "audioList", ofType: "plist")
        
        let inputDataArray = NSArray(contentsOfFile: inputFile!)
        
        for inputItem in inputDataArray as! [Dictionary<String, String>] {
            let musicItem = MusicItem(dataDictionary: inputItem)
            items.append(musicItem)
        }
        
        musicItems = items
    }
    
    // MARK: -
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryItemCollectionViewCell", for: indexPath) as! GalleryItemCollectionViewCell

        cell.setGalleryItem(galleryItems[indexPath.row])


        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = indexPath
        self.performSegue(withIdentifier: "fullscreenSegue", sender: self)

    }


    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        perform(#selector(self.actionOnFinishedScrolling), with: nil, afterDelay: Double(velocity.y))
    }

    func actionOnFinishedScrolling() {
        let visibleCells = collectionView.visibleCells
        let sorted = visibleCells.sorted(){ $0.center.y < $1.center.y }

        self.collectionView?.scrollToItem(at: collectionView.indexPath(for: sorted.last!)!,
                                          at: .bottom,
                                          animated: true)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }

        let heightAvailbleForAllItems =  (collectionView.frame.height - flowLayout.sectionInset.top - flowLayout.sectionInset.bottom)

        let widthAvailbleForAllItems =  (collectionView.frame.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right)

        let widthForOneItem = widthAvailbleForAllItems / 2 - flowLayout.minimumInteritemSpacing
        let heightForOneItem = heightAvailbleForAllItems / 4 - flowLayout.minimumInteritemSpacing

        return CGSize(width: CGFloat(widthForOneItem), height:  CGFloat(heightForOneItem))
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fullscreenSegue" {

            let playerVC = segue.destination as! PlayerViewController
            playerVC.trackId = (selectedItem?.row)!
            playerVC.musicItems = musicItems
            playerVC.imageIndex = selectedItem
        }
    }

    func rotated() {
        collectionView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    var pressActionStarted = false
    var currentCell: GalleryItemCollectionViewCell!
    var currentIndexPath: IndexPath!


    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {

        if(!pressActionStarted){


        let p = gestureReconizer.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: p)

        if let index = indexPath {
            currentIndexPath = index
            let cell = self.collectionView.cellForItem(at: index)
            currentCell = cell as! GalleryItemCollectionViewCell
            let trackId = index.row

            self.currentCell.itemImageView.addAnimatedBlurEffect()

            currentCell.closePlayer()
            currentCell.showVideo(musicItems[trackId].videoAddress)
            print(index.row)
        } else {
            print("Could not find index path")
        }
            pressActionStarted = true
        }

                if gestureReconizer.state == UIGestureRecognizerState.ended {
                    currentCell.closePlayer()
                    currentCell.activityIndicator.isHidden = true
                    pressActionStarted = false

                    currentCell.itemImageView.animatedRemoveBlurEffect()
                    print("Finish-------")

                }
    }
}

