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

extension PlayerViewController {


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
        cell.containerView.frame = imageView.bounds
        cell.closePlayer()
        cell.index = indexPath.row


        return cell
    }

    func temp() {

    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        let currentCell = cell  as! FullScreenCollectionViewCell
        trackId = indexPath.row
        currentCell.closePlayer()
        currentCell.showVideo(musicItems[trackId].videoAddress)
        
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let currentCell = cell  as! FullScreenCollectionViewCell
        trackId = indexPath.row
        currentCell.closePlayer()
    }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height )
    }


//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
//                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        perform(#selector(self.actionOnFinishedScrolling), with: nil, afterDelay: Double(velocity.x))
//    }
//
//    func actionOnFinishedScrolling() {
//        if let visibleCell = collectionView.visibleCells.last {
//            //get Id of current cell
//        trackId = collectionView.indexPath(for: visibleCell)!.row
//            //if ids changed
//            let currentCell = collectionView.cellForItem(at: IndexPath(item: trackId, section: 0)) as! FullScreenCollectionViewCell
//            if (previousCell.index != currentCell.index) {
//                previousCell.closePlayer()
//                currentCell.showVideo(musicItems[trackId].videoAddress)
//            }
//
//        }
//    }
//
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        if let visibleCell = collectionView.visibleCells.last {
//            lastVisibleCellNumber = collectionView.indexPath(for: visibleCell)!.row
//            previousCell = collectionView.cellForItem(at: IndexPath(item: lastVisibleCellNumber, section: 0)) as! FullScreenCollectionViewCell
//        }
//    }


}
