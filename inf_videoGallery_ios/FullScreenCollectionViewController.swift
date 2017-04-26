//
//  FullScreenCollectionViewController.swift
//  infGalleryIOS
//
//  Created by Kamil Buczel on 29.03.2017.
//  Copyright © 2017 Kamajabu. All rights reserved.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "CollectionViewCell"

extension PlayerViewController: CollectionViewCellDelegate {


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FullScreenCollectionViewCell

        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: cell.frame.width, height: cell.frame.height)))

        let item = musicItems[indexPath.row]
        let image = UIImage(named: item.itemImage)

        imageView.image = image
        imageView.addBlurEffect()
        cell.backgroundView = UIView()
        cell.backgroundView!.addSubview(imageView)

//        cell.setGalleryItem(musicItems[indexPath.row])
//        cell.loadPlayer()
        cell.closeDelegate = self


        return cell
    }

    func temp() {

    }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height )
    }

    func cellDelegateCloseController(sender: AnyObject){
        dismiss(animated: true, completion: nil)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        perform(#selector(self.actionOnFinishedScrolling), with: nil, afterDelay: Double(velocity.y))
    }

    func actionOnFinishedScrolling() {
        if let visibleCell = collectionView.visibleCells.last {
        trackId = collectionView.indexPath(for: visibleCell)!.row
        }

        audioPlayer.currentTime = 0
        progressView.progress = 0

        chooseImageTitleArtist(trackId)
        loadMp3(trackId)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let visibleCell = collectionView.visibleCells.last {
            let cell = visibleCell as! FullScreenCollectionViewCell
            cell.stopPlayer()
        }
    }


}
