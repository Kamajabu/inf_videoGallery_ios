//
//  CollectionViewCell.swift
//  Example
//
//  Created by Benjamin Emdon on 2016-12-28.
//  Copyright © 2016 Benjamin Emdon.
//

import UIKit

protocol CollectionViewCellDelegate: class {
    func cellDelegateCloseController(sender: AnyObject)
}
class FullScreenCollectionViewCell: UICollectionViewCell {

    weak var closeDelegate: CollectionViewCellDelegate?

    @IBOutlet weak var itemImage: UIImageView!

    func setGalleryItem(_ item:MusicItem) {
        itemImage.image = UIImage(named: item.itemImage)
    }
}

