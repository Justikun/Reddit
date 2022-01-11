//
//  postTableViewCell.swift
//  Reddit
//
//  Created by Justin Lowry on 1/5/22.
//

import UIKit

class postTableViewCell: UITableViewCell {
    // MARK: - Properties
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postUpsLabel: UILabel!
    
    // MARK: - Helper Methods
    func updateViews() {
        guard let post = post else { return }
        postTitleLabel.text = post.title
        postUpsLabel.text = "Upvotes: \(post.ups)"
        
        PostController.fetchThumbnail(for: post) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let thumbnail):
                    self.postImageView.image = thumbnail
                case .failure(let error):
                    self.postImageView.image = UIImage.init(systemName: "photo")
                    print("Error in \(#function) : \(error.localizedDescription)\n---\n\(error)")
                }
            }
        }
    }
}
