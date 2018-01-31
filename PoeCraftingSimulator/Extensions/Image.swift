//
//  Image.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 20/12/2017.
//  Copyright © 2017 Markus. All rights reserved.
//

import Foundation
import UIKit

public extension UIImageView {
    public func imageFromServerURL(urlString: String, defaultImage : String?) {
        if let di = defaultImage {
            self.image = UIImage(named: di)
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}

public extension UIImage {
    var noir: UIImage {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectNoir")!
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        let output = currentFilter.outputImage!
        let cgImage = context.createCGImage(output, from: output.extent)!
        let processedImage = UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        
        return processedImage
    }
}
