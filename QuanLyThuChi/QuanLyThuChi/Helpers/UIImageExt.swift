//
//  UIImageExt.swift
//  QuanLyQuanAn
//
//  Created by Shin-Mac on 4/11/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    var jpegRepresentationData: NSData! {
        return UIImageJPEGRepresentation(self, 1.0)! as NSData   // QUALITY min = 0 / max = 1
    }
    var pngRepresentationData: NSData! {
        return UIImagePNGRepresentation(self)! as NSData
    }
}

extension UIImage{
    
    func alpha(_ value:CGFloat)->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
}
