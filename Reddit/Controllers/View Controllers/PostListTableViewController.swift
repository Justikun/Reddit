//
//  PostListTableViewController.swift
//  Reddit
//
//  Created by Justin Lowry on 1/5/22.
//

import UIKit

class PostListTableViewController: UITableViewController {
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    var posts: [Post] = []
    
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Helper Methods
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? postTableViewCell else { return UITableViewCell() }

        let post = posts[indexPath.row]
        
        cell.post = post
        
        return cell
    }
} // end of class

extension PostListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        guard let searchTerm = searchBar.text,
              !searchTerm.isEmpty else { return }
        PostController.fetchPosts(with: searchTerm) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n\(error)")
                }
            }
        }
    }
    
} // End of UISearchBar Delegate
