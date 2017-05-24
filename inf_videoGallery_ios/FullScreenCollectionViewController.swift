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

        currentCell = cell as! FullScreenCollectionViewCell
        trackId = indexPath.row
        currentCell.closePlayer()
        currentCell.showVideo(musicItems[trackId].videoAddress)
        NotificationCenter.default.post(name: ChangeVideoNotifications.videoChanged, object: nil)


    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var currentCell = cell  as! FullScreenCollectionViewCell
        trackId = indexPath.row
        currentCell.closePlayer()
    }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height )
    }
}
