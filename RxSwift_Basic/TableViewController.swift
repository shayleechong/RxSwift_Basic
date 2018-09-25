//
//  TableViewController.swift
//  RxSwift_Basic
//
//  Created by Shaylee Chong on 21/9/18.
//  Copyright © 2018 Shaylee Chong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TableViewController: UIViewController{
    
    let tableViewModel = TableViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewModel.loadAlbums()
        
        tableViewModel.albums
                      .
        
        
    }

}
