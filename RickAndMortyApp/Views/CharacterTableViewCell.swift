//
//  XibTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Yevhen Shevchenko on 18.03.2021.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    static let id = "CharacterTableViewCell"

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    private var path: String?
    
    override func prepareForReuse() {
        characterImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        characterImageView.layer.cornerRadius = characterImageView.bounds.height / 2
    }
    
    func configure(with result: Result?) {
        accessoryType = .disclosureIndicator
        path = result?.image
        
        activityIndicatorView.startAnimating()
        nameLabel.text = result?.name
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let stringUrl = result?.image else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            guard self.path == stringUrl else { return }

            DispatchQueue.main.async {
                self.characterImageView.image = UIImage(data: imageData)
                self.activityIndicatorView.stopAnimating()
            }
        }
        
    }
    
}
