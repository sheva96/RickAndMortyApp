//
//  DetailTableViewController.swift
//  RickAndMortyApp
//
//  Created by Yevhen Shevchenko on 17.03.2021.
//

import UIKit

class CharactersListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var results = [Result]()
    private var filteredResults = [Result]()
    
    private var page = 1
    private let rowHeight: CGFloat = 100
    
    private var isFiltererd: Bool {
        searchController.isActive && !searchBarIsEmpty
    }
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: CharacterTableViewCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CharacterTableViewCell.id)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        fetchData(page: page)
    }
    
    // MARK: Actions
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        sender.selectedSegmentIndex == 0
            ? results.sort { $0.name ?? "" < $1.name ?? "" }
            : results.sort { $0.name ?? "" > $1.name ?? "" }
        
        tableView.reloadData()
    }
    
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
    
    // MARK: Private methods
    
    private func fetchData(page: Int) {
        NetworkManager.shared.fetchData(page: page) { [weak self] data in
            self?.results.append(contentsOf: data.results ?? [])
            self?.tableView.reloadData()
        }
    }
}

// MARK: - Table view data source

extension CharactersListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltererd ? filteredResults.count : results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.id, for: indexPath) as! CharacterTableViewCell
        
        let character = isFiltererd ? filteredResults[indexPath.row] : results[indexPath.row]
        cell.configure(with: character)

        return cell
    }
}

// MARK: - Table view delegate

extension CharactersListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rowHeight
    }
}

// MARK: - Scroll view delegate

extension CharactersListViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - scrollView.frame.height {
            page += 1
            fetchData(page: page)
        }
    }
}


// MARK: - Navigation

extension CharactersListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let detailTVC = segue.destination as! DetailTableViewController
        detailTVC.result = results[indexPath.row]
    }
}


// MARK: - SearchResultsUpdating

extension CharactersListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterForSearchText(searchController.searchBar.text!)
    }
    
    func filterForSearchText(_ searchText: String) {
        filteredResults = results.filter { $0.name!.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
}
