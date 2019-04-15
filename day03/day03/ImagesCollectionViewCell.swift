//
//  ImagesCollectionViewCell.swift
//  day03
//
//  Created by Kateryna KOSTRUBOVA on 4/5/19.
//  Copyright © 2019 Kateryna KOSTRUBOVA. All rights reserved.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    func spinner(shouldSpin status: Bool) {
        if status == true {
            spinner.isHidden = false
            spinner.startAnimating()
        } else {
            spinner.isHidden = true
            spinner.stopAnimating()
        }
    }
}
