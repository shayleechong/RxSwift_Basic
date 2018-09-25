//
//  Album.swift
//  RxSwift_Basic
//
//  Created by Shaylee Chong on 21/9/18.
//  Copyright © 2018 Shaylee Chong. All rights reserved.
//
import Foundation

class Album : Decodable {
    
    var albumId : Int
    var id : Int
    var title : String
    var url : String
    var thumbnailUrl : String
    
    init(albumId : Int, id : Int, title : String, url : String, thumbnailUrl : String) {
        
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
        
    }
    
    init?(json: [String : Any]){
        
        guard let albumId = json["albumId"] as? Int,
              let id = json["id"] as? Int,
              let title = json["title"] as? String,
              let url = json["url"] as? String,
              let thumbnailUrl = json["thumbnailUrl"] as? String
        else { return nil }
        
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
    
    
}
