//
//  MusicItem.swift
//  inf_musicGallery_ios
//
//  Created by Kamil Buczel on 25.04.2017.
//  Copyright © 2017 Kamajabu. All rights reserved.
//

import Foundation

class MusicItem {
    var fileName: String
    var itemImage: String
    var title: String
    var artist: String
    var videoAddress: String

    //in prod app strings should be extracted to consts
    
    init(dataDictionary:Dictionary<String,String>) {
        fileName = dataDictionary["fileName"]!
        artist = dataDictionary["artist"]!
        title = dataDictionary["title"]!
        itemImage = dataDictionary["itemImage"]!
        videoAddress = dataDictionary["videoAddress"]!


    }

    class func newGalleryItem(_ dataDictionary:Dictionary<String,String>) -> GalleryItem {
        return GalleryItem(dataDictionary: dataDictionary)
    }

}
