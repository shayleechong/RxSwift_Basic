//
//  RxSimple.swift
//  RxSwift_Basic
//
//  Created by Shaylee Chong on 20/9/18.
//  Copyright © 2018 Shaylee Chong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RxSimple {
    
    var disposeBag = DisposeBag()
    
}

extension RxSimple{
    
    static var shared = RxSimple()
    
    func variables() {
        
        print("~~~~~~BehaviorRelay~~~~~~")
        
        let someInfo = BehaviorRelay(value: "BANANA")
        
        print("someInfo.value: \(someInfo.value)")
        
        let plainString = someInfo.value
        print("plainString: \(plainString)")
        
        someInfo.accept("POTATOO")
        print("someInfo.value: \(someInfo.value)")
        
        someInfo.accept("PUTA")
        
        someInfo.asObservable().subscribe(onNext: { newValue in
            print("value has changed: \(newValue)")
        }).disposed(by: disposeBag)
        
        
        someInfo.accept("NWXR")
        
    }
}

extension RxSimple {
    
    
    func behaviorSubject() {
        
        print("~~~~~~Behavior Subject~~~~~~")
        
        let subject = BehaviorSubject(value: "Initial value")
        
        subject.subscribe(onNext: { newValue in
            print("behaviorSubject subscription: \(newValue)")
            
        }, onError: { error in
            print("Error: \(error.localizedDescription)")
        }, onCompleted: {
            print("COMPLETED")
        }, onDisposed:{
            print("DISPOSED")
        }
        ).disposed(by: disposeBag)
        
        let another = Observable.from(["s","f","g","g","oe","plead","mp"])
        
        another.subscribe(onNext: { nextValue in
            print("Another Subscription: \(nextValue)")
        }, onError: { error in
            print("Error: \(error.localizedDescription)")
        }, onCompleted: {
            print("Completed")
        }, onDisposed: {
            print("Disposed")
        }).disposed(by: disposeBag)
        
        another.bind(to: subject).disposed(by: disposeBag)
        



        
    }
}

extension RxSimple{
    
    func basicObservarables() {
        
        print("~~~~~~Basic Observerable~~~~~~")
        
        let watcher = Observable<String>.create{ observer in
            
            DispatchQueue.global().async {
                Thread.sleep(forTimeInterval: 5)
                
                observer.onNext("NEXT")
                observer.onCompleted()
            }
            return Disposables.create {
                print("Clean up")
            }
        }
        
        watcher.subscribe(onNext: { nextString in
            print("Subscrible One ☝🏻: \(nextString)")
        }, onError: { error in
            print("Error: \(error.localizedDescription)")
        }, onCompleted: {
            print("Completed")
        }, onDisposed: {
            print("Disposed")
        }).disposed(by: disposeBag)
        
        watcher.subscribe(onNext: { string in
            print("Subscrible Two ✌🏻: \(string)")
        }).disposed(by: disposeBag)
        
        
    }
}
