//
//  PostService.swift
//  Makestagram
//
//  Created by Asher Rosenblatt on 6/27/17.
//  Copyright © 2017 AVRTech. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase

struct PostService
{
    static func create(for image: UIImage)
    {
        let imageRef = StorageReference.newPostImageReference()
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let  downloadURL = downloadURL else { return }
            let urlString = downloadURL.absoluteString
            let aspectHeight = image.aspectHeight
            create(forURLString: urlString, aspectheight: aspectHeight)
        }
    }
    
    private static func create(forURLString urlString: String, aspectheight: CGFloat)
    {
        let currentUser = User.current
        let post = Post(imageURL: urlString, imageHeight: aspectheight)
        let dict = post.dictValue
        let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
        postRef.updateChildValues(dict)
    }
}
