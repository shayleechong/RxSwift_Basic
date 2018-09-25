//
//  TableViewModel.swift
//  RxSwift_Basic
//
//  Created by Shaylee Chong on 24/9/18.
//  Copyright © 2018 Shaylee Chong. All rights reserved.
//

import RxSwift
import RxCocoa

class TableViewModel {
    
    var albums = BehaviorRelay<[Album]>(value: [])
    
    var sections = BehaviorRelay<[SectionOfAlbums]>(value: [])
    
    static let shared = TableViewModel()
    
    private var disposeBag = DisposeBag()
    private var networkLayer = NetworkLayer()
    
}

extension TableViewModel {
    
    func loadAlbums(){
        
        loadAlbum { albums in
            albums.subscribe(onNext: { album in
                
                        self.albums.accept(album)
            
                        self.sections.accept([SectionOfAlbums(items: album)])
                
                  }, onError: { err in
                        print(err.localizedDescription)
                  }, onCompleted: {
                        print("Finish parasing to view model")
                  }).disposed(by: self.disposeBag)
        }
    }
    
    func loadAlbum(completed: @escaping (BehaviorRelay<[Album]>) -> ()){
        
        networkLayer.loadViaRxAlamofire()
                    .subscribe(onNext: { [weak self] response, data in
                        
                        self?.parse(data: data, completed: completed)
                        
                    }, onError: { error in
                        print(error.localizedDescription)
                    }, onCompleted: {
                        print("COMPLETED")
                    }).disposed(by: disposeBag)

    }
    
    func parse(data: Any, completed: @escaping (BehaviorRelay<[Album]>) -> ()){
        
        networkLayer.parse(data: data)
                    .subscribe(onNext: { albums in
                        completed(albums)
                        self.albums = albums
                    }, onError: { error in
                        print(error.localizedDescription)
                    }, onCompleted: {
                        print("Parse Completed")
                    })
                    .disposed(by: disposeBag)
        
    }
}
