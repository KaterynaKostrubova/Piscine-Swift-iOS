//
//  scrollCollectionViewCell.swift
//  day03
//
//  Created by Kateryna KOSTRUBOVA on 4/5/19.
//  Copyright © 2019 Kateryna KOSTRUBOVA. All rights reserved.
//

import UIKit

class scrollCollectionViewCell: UIViewController, UIScrollViewDelegate {
   
    var image: UIImage?
    var imageView: UIImageView?
    
    @IBOutlet weak var Viewscroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Viewscroll.delegate = self
        imageView = UIImageView(image: image)
        Viewscroll.addSubview(imageView!)
        Viewscroll.contentSize = (imageView?.frame.size)!
        Viewscroll.maximumZoomScale =  100
        Viewscroll.minimumZoomScale =  0.3
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
