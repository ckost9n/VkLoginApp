//
//  FriendsTableViewController.swift
//  VkLoginApp
//
//  Created by Konstantin on 20.10.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    private var users: [User] = []
    private var filteredUsers: [User] = []
    private var sectionsFiltered: [String] = []
    private var sections: [String] = []
    let seaerchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
        return seaerchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return seaerchController.isActive && !isSearchBarEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupSearchController()
    }
    
    func setupData() {
        users = User.takeUser(count: 50).sorted { $0.lastName < $1.lastName }
        let leterUser = Set(users.map ({ String($0.lastName.prefix(1).capitalized) }))
        sections = Array(leterUser).sorted()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let user = itemsInSection(indexPath.section)[indexPath.row]
        
        guard segue.identifier == "photoSegue" else { return }
        guard let photoVC = segue.destination as? PhotoCollectionViewController else { return }
        
        photoVC.user = user

    }

    // MARK: - Table view data source
    
    func itemsInSection(_ section: Int) -> [User] {
        let letter = isFiltering ? sectionsFiltered[section] : sections[section]
        return isFiltering ? filteredUsers.filter {
            $0.lastName.hasPrefix(letter) } : users.filter { $0.lastName.hasPrefix(letter)
            }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering ? sectionsFiltered.count : sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return isFiltering ? sectionsFiltered[section] : sections[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return isFiltering ? sectionsFiltered : sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsInSection(section).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        
        let user = itemsInSection(indexPath.section)[indexPath.row]
        
        cell.nameLabel.text = user.fullName
        cell.imageUser.image = user.image.first

        return cell
    }

   

}

// MARK: - SearchBarController

extension FriendsTableViewController: UISearchResultsUpdating {
    
    func setupSearchController() {
        seaerchController.searchResultsUpdater = self
        seaerchController.obscuresBackgroundDuringPresentation = false
        seaerchController.searchBar.placeholder = "Search Friends"
        navigationItem.searchController = seaerchController
        definesPresentationContext = true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredUsers = users.filter { (user: User) -> Bool in
            return user.fullName.lowercased().contains(searchText.lowercased())
        }
        let leterFilteredUser = Set(filteredUsers.map ({ String($0.lastName.prefix(1).capitalized) }))
        sectionsFiltered = Array(leterFilteredUser).sorted()
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
}
