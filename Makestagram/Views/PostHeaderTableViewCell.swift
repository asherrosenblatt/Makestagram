//
//  PostHeaderTableViewCell.swift
//  Makestagram
//
//  Created by Asher Rosenblatt on 6/27/17.
//  Copyright © 2017 AVRTech. All rights reserved.
//

import UIKit

class PostHeaderTableViewCell: UITableViewCell
{
    @IBOutlet weak var usernameLabel: UILabel!
    static let height: CGFloat = 54
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }

    @IBAction func onOptionsButtonPressed(_ sender: Any)
    {
        
    }
}
