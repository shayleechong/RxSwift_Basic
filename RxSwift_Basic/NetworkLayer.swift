//
//  NetworkLayer.swift
//  RxSwift_Basic
//
//  Created by Shaylee Chong on 21/9/18.
//  Copyright © 2018 Shaylee Chong. All rights reserved.
//

import RxSwift
import RxCocoa
import Alamofire
import RxAlamofire

class NetworkLayer{
    
    let disposeBag = DisposeBag()
        
    func loadViaRxAlamofire() ->  Observable<(HTTPURLResponse, Any)> {
        
        return RxAlamofire.requestJSON(.get, "https://jsonplaceholder.typicode.com/photos")
        
    }
    
    func parse( data : Any) -> Observable<BehaviorRelay<[Album]>>{
        
        let jsonData = data as! [[String: Any]]
        
        let albums = Observable.just(BehaviorRelay<[Album]>(value: jsonData.compactMap { album -> Album in
            
            let id = album["id"] as! Int
            let title = album["title"] as! String
            let urlString = album["url"] as! String
            let albumId = album["albumId"] as! Int
            let thumbnailUrlString = album["thumbnailUrl"] as! String
            
            return Album(albumId: albumId, id: id, title: title, url: urlString, thumbnailUrl: thumbnailUrlString)
            
        }))
        
        return albums

    }
}
