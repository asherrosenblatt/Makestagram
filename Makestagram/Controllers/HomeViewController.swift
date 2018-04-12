//
//  HomeViewController.swift
//  Makestagram
//
//  Created by Asher Rosenblatt on 6/27/17.
//  Copyright © 2017 AVRTech. All rights reserved.
//
import UIKit
import Kingfisher

class HomeViewController: UIViewController
{
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    let timeStampFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureTableView()
        UserService.posts(for: User.current) { (posts) in
            self.posts = posts
            self.tableView.reloadData()
        }
    }
    
    func configureTableView()
    {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }

}

extension HomeViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let post = posts[indexPath.section]

        switch indexPath.row
        {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell", for: indexPath) as! PostHeaderTableViewCell
                cell.usernameLabel.text = User.current.username
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell", for: indexPath) as! PostImageTableViewCell
                let imageURL = URL(string: post.imageURL)
                cell.postImageView.kf.setImage(with: imageURL)
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PostActionCell") as! PostActionTableViewCell
                cell.delegate = self
                configureCell(cell, with: post)
                return cell
            default:
                fatalError("Error: unexpexted index path ")
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return posts.count
    }
    
    func configureCell (_ cell: PostActionTableViewCell, with post: Post)
    {
        cell.timeAgoLabel.text = timeStampFormatter.string(from: post.creationDate)
        cell.likeCountLabel.text = "\(post.likeCount) likes"
        cell.likeButton.isSelected = post.isLiked
    }
}

extension HomeViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.row
        {
            case 0:
                return PostHeaderTableViewCell.height
            case 1:
                let post = posts[indexPath.section]
                return post.imageHeight
            case 2:
                return PostActionTableViewCell.height
            default:
                fatalError()
        }
    }
}

extension HomeViewController: PostActionTableViewCellDelegate
{
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostActionTableViewCell)
    {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        likeButton.isUserInteractionEnabled = false
        let post = posts[indexPath.section]
        LikeService.setIsLiked(!post.isLiked, for: post) { (success) in
            defer
            {
                likeButton.isUserInteractionEnabled = true
            }
            guard success else { return }
            
            post.likeCount += !post.isLiked ? 1 : -1
            post.isLiked = !post.isLiked
            
            guard let cell = self.tableView.cellForRow(at: indexPath) as? PostActionTableViewCell else { return }
            
            DispatchQueue.main.async {
                self.configureCell(cell, with: post)
            }
        }
    }
}



