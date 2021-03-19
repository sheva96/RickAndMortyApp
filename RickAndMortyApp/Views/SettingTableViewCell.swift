//
//  SettingTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Yevhen Shevchenko on 18.03.2021.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    static let id = "SettingTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: SettingsOption) {
        backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        
        var content = defaultContentConfiguration()
        content.text = model.title
        content.secondaryText = model.secondaryTitle
        content.image = UIImage(systemName: model.icon ?? "")
        
        contentConfiguration = content
    }

}
