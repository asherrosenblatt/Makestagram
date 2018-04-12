//
//  PostActionTableViewCell.swift
//  Makestagram
//
//  Created by Asher Rosenblatt on 6/27/17.
//  Copyright © 2017 AVRTech. All rights reserved.
//

import UIKit

protocol PostActionTableViewCellDelegate: class
{
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostActionTableViewCell)
}

class PostActionTableViewCell: UITableViewCell
{
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    static let height: CGFloat = 46
    weak var delegate: PostActionTableViewCellDelegate?

    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }

    @IBAction func onLikeButtonPressed(_ sender: UIButton)
    {
        delegate?.didTapLikeButton(sender, on: self)
    }
}
