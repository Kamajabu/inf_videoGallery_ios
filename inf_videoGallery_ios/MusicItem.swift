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

    init(dataDictionary:Dictionary<String,String>) {
        fileName = dataDictionary["fileName"]!
        artist = dataDictionary["artist"]!
        title = dataDictionary["title"]!
        itemImage = dataDictionary["itemImage"]!

    }

    class func newGalleryItem(_ dataDictionary:Dictionary<String,String>) -> GalleryItem {
        return GalleryItem(dataDictionary: dataDictionary)
    }

}



//var library = [["title":"Closer-Wrap me in Your Arms","artist":"William McDowell","index":"0","coverImage":"0"],["title":"Falling in love with Jesus","artist":"Jonathan Buttler","index":"1","coverImage":"1"],["title":"Holyness medley sax","artist":"Micah Stampley","index":"2","coverImage":"2"],["title":"I could sing of your love","artist":"Unknown Artist","index":"3","coverImage":"3"],["title":"I surrender I give myself","artist":"William McDowell","index":"4","coverImage":"4"]]
