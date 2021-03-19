//
//  PhotoTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Yevhen Shevchenko on 18.03.2021.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    static let id = "PhotoTableViewCell"

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.layer.cornerRadius =  photoImageView.layer.frame.height / 2
    }
    
    func configure(with url: String?) {
        backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        
        activityIndicatorView.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let stringUrl = url else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }

            DispatchQueue.main.async {
                self.photoImageView.image = UIImage(data: imageData)
                self.activityIndicatorView.stopAnimating()
            }
        }
        
    }
}
