//
//  ViewController.swift
//  RxSwift_Basic
//
//  Created by Shaylee Chong on 20/9/18.
//  Copyright © 2018 Shaylee Chong. All rights reserved.
//

import UIKit
import RxAlamofire
import Alamofire
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    let tapGestureRecognizer = UITapGestureRecognizer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
        
        view.addGestureRecognizer(tapGestureRecognizer)
        
//        tapGestureRecognizer.rx
//                            .event
//                            .asDriver()
//                            .drive(onNext: { _ in
//                                self.counter = self.counter + 1
//                                print(self.counter)
//                                print("Screen tapped")
//                            }).disposed(by: disposeBag)
        
        dataInit()
        
//        loadViaRxAlamofire().asObservable()
//                            .observeOn(MainScheduler.instance)
//                            .subscribe(onNext: { response, result in
//                                print(response.statusCode)
//                                print(result)
//                            }, onError: { error in
//                                print("Error: \(error.localizedDescription)")
//                            }).disposed(by: disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController{
    
    func dataInit(){
        
        loadData().asObservable()
                  .observeOn(MainScheduler.instance)
                  .subscribe(onNext: { posting in
                        print(posting.id!)
                  })
                  .disposed(by: disposeBag)
        
    }
    
    func loadViaRxAlamofire() ->  Observable<(HTTPURLResponse, Any)> {
        
       return RxAlamofire.requestJSON(.get, "https://jsonplaceholder.typicode.com/todos/1")
  
    }
    
    func loadData() -> Observable<Posting> {
        
        print("~~~~~~~~Loading Data~~~~~~~~~~~")
        return Observable.create{ observer in
            let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                
                guard error == nil else { observer.onError(error!) ; print("Error"); return }
                guard let data = data else { observer.onError(error!) ; print("Error Data") ; return }
                guard let strongSelf = self else { return }
                
                let posting = strongSelf.parse(data)
                
                observer.onNext(posting)
                observer.onCompleted()
            
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func parse(_ data: Data) -> Posting{
        
        let jsonData = try! JSONSerialization.jsonObject(with: data) as! [String : Any]
        
        return Posting(userId: jsonData["userId"] as? Int ,
                       id: 1,
                       title: "",
                       completed: true)
    }
}


























