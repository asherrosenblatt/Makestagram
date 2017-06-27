//
//  Storyboard+Utility.swift
//  Makestagram
//
//  Created by Asher Rosenblatt on 6/27/17.
//  Copyright © 2017 AVRTech. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard
{
    enum MGType: String
    {
        case main
        case login
        
        var filename: String
        {
            return rawValue.capitalized
        }
    }
    
    convenience init(type: MGType, bundle: Bundle? = nil)
    {
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initialViewController(for type: MGType) -> UIViewController
    {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewControler = storyboard.instantiateInitialViewController() else { fatalError("Couldnt instantiate initial VC for \(type.filename) storyboard")}
        return initialViewControler
    }
}
