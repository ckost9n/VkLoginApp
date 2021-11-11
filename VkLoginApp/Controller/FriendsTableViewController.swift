//
//  FriendsTableViewController.swift
//  VkLoginApp
//
//  Created by Konstantin on 20.10.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    lazy var service = VKService()
    
    private var friends: [Friend] = []
    private var filteredFriends: [Friend] = []
    private var sectionsFriend: [String] = []
    private var sectionsFriendFiltered: [String] = []
    
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
        setupSearchController()
        
        service.getFriends { [weak self] (friends) in
            self?.friends = friends
                .filter { $0.deactivated != "deleted" }
                .sorted { $0.lastName < $1.lastName }
            let leterUser = self?.friends.map ({ String($0.lastName.prefix(1).capitalized) })
            self?.sectionsFriend = Array(Set(leterUser!)).sorted()
            self?.tableView.reloadData()
            //            print(Session.shared.token)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let friend = itemsInSectionFriends(indexPath.section)[indexPath.row]
        
        guard segue.identifier == "photoSegue" else { return }
        guard let photoVC = segue.destination as? PhotoCollectionViewController else { return }
        
        photoVC.userId = String(friend.id)

    }

    // MARK: - Table view data source
    
    func itemsInSectionFriends(_ section: Int) -> [Friend] {
        let letterNew = isFiltering ? sectionsFriendFiltered[section] : sectionsFriend[section]
        return isFiltering ? filteredFriends.filter {
            $0.lastName.hasPrefix(letterNew) } : friends.filter { $0.lastName.hasPrefix(letterNew)
            }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering ? sectionsFriendFiltered.count : sectionsFriend.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return isFiltering ? sectionsFriendFiltered[section] : sectionsFriend[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return isFiltering ? sectionsFriendFiltered : sectionsFriend
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsInSectionFriends(section).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        
        let friend = itemsInSectionFriends(indexPath.section)[indexPath.row]
        cell.configure(friend: friend)

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
        
        filteredFriends = friends.filter { (friend: Friend) -> Bool in
            return friend.fullName.lowercased().contains(searchText.lowercased())
        }
        let leterFilteredUserNew = Set(filteredFriends.map ({ String($0.lastName.prefix(1).capitalized) }))
        sectionsFriendFiltered = Array(leterFilteredUserNew).sorted()
        
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
}
