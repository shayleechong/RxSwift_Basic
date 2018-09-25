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
import RxDataSources


class TableViewController: UIViewController{
    
    let tableViewModel = TableViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewModel.loadAlbums()
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfAlbums>(
                            configureCell: { dataSource, tableView, indexPath, album in
                                                let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumTableViewCell
                                
                                                cell.downloadImage(url: album.url)
                                                cell.albumTitleLabel.text = album.title
                                                cell.albumIdLabel.text = String(album.id)
                                                cell.albumInvIdLabel.text = String(album.albumId)

                                                return cell
                                            }
                         )
        
        tableViewModel.sections
                      .bind(to: tableView.rx.items(dataSource: dataSource))
                      .disposed(by: disposeBag)
        
        

        
    }

}
