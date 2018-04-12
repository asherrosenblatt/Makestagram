//
//  FindFriendsTableViewCell.swift
//  Makestagram
//
//  Created by Asher Rosenblatt on 6/30/17.
//  Copyright © 2017 AVRTech. All rights reserved.
//

import UIKit

protocol FindFriendsTableViewCellDelegate: class
{
    func didTapFollowButton(_ followButton: UIButton, on cell: FindFriendsTableViewCell)
}

class FindFriendsTableViewCell: UITableViewCell
{
    weak var delegate: FindFriendsTableViewCellDelegate?
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        followButton.layer.borderColor = UIColor.lightGray.cgColor
        followButton.layer.borderWidth = 1
        followButton.layer.cornerRadius = 6
        followButton.clipsToBounds = true
        
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitle("Following", for: .selected)
    }

    
    @IBAction func onFollowButtonPressed(_ sender: UIButton)
    {
        delegate?.didTapFollowButton(sender, on: self)
    }
    
}
