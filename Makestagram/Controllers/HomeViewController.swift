//
//  HomeViewController.swift
//  Makestagram
//
//  Created by Asher Rosenblatt on 6/27/17.
//  Copyright © 2017 AVRTech. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController
{
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        UserService.posts(for: User.current) { (posts) in
            self.posts = posts
            self.tableView.reloadData()
        }
    }

}

extension HomeViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}

extension HomeViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let post = posts[indexPath.row]
        return post.imageHeight
    }
}
