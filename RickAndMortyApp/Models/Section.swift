//
//  Section.swift
//  RickAndMortyApp
//
//  Created by Yevhen Shevchenko on 18.03.2021.
//

import Foundation

struct Section {
    let title: String
    let options: [SettingsOption]
}

struct SettingsOption {
    let title: String?
    let secondaryTitle: String?
    let icon: String?
}
