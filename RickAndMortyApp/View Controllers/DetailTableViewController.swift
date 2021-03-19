//
//  DetailTableViewController.swift
//  RickAndMortyApp
//
//  Created by Yevhen Shevchenko on 17.03.2021.
//

import UIKit



class DetailTableViewController: UITableViewController {
    
    var result: Result?
    
    private var models: [Section] {
        [
            Section(title: "Photo", options: [
                SettingsOption(title: nil, secondaryTitle: nil, icon: result?.image),
            ]),
            Section(title: "Info", options: [
                SettingsOption(title: "Species", secondaryTitle: result?.species, icon: "face.dashed"),
                SettingsOption(title: "Gender", secondaryTitle: result?.gender, icon: "person.2"),
                SettingsOption(title: "Status", secondaryTitle: result?.status, icon: "checkmark.circle"),
                SettingsOption(title: "Location", secondaryTitle: result?.location?.name, icon: "map"),
                SettingsOption(title: "Origin", secondaryTitle: result?.origin?.name, icon: "location"),
            ]),
            Section(title: "Episodes", options: [
                SettingsOption(title: "Episodes", secondaryTitle: "\(result?.episode?.count ?? 0)", icon: nil)
            ]),
        ]
    }

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: PhotoTableViewCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PhotoTableViewCell.id)
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.id)
        
        title = result?.name
    }
   
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models[section].options.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.id, for: indexPath) as! PhotoTableViewCell
            cell.configure(with: model.icon)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.id, for: indexPath) as! SettingTableViewCell
            cell.configure(with: model)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        models[section].title
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 0 ? 100 : 43
    }
}
