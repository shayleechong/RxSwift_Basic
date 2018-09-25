//
//  AlbumTableViewCell.swift
//  RxSwift_Basic
//
//  Created by Shaylee Chong on 25/9/18.
//  Copyright © 2018 Shaylee Chong. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumImageView: UIImageView!
    
    @IBOutlet weak var albumIdLabel: UILabel!
    
    @IBOutlet weak var albumTitleLabel: UILabel!
    
    @IBOutlet weak var albumInvIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: String) {
        
        guard let imageURL = URL(string: url) else {
            print("Invaild image URL")
            return
        }
        
        getDataFromUrl(url: imageURL) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? imageURL.lastPathComponent)
            
            DispatchQueue.main.async() {
                self.albumImageView.image = UIImage(data: data)
            }
        }
    }

}
