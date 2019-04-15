//
//  Shape.swift
//  d06
//
//  Created by Kateryna KOSTRUBOVA on 4/9/19.
//  Copyright © 2019 Kateryna KOSTRUBOVA. All rights reserved.
//

import UIKit

class Shape: UIView {
    
    var path: UIBezierPath!
    var size : CGFloat = 100
    var isCircle = false
    
    init(point: CGPoint, maxwidth: CGFloat, maxheight: CGFloat) {
        
        var x = point.x
        var y = point.y
        
        if y+size/2 > maxheight {
            y -= size/2
        }
        
        if x+size/2 > maxwidth {
            x -= size/2
        }

        let random = Int(arc4random_uniform(2))
        switch random {
        case 0 :
            super.init(frame: CGRect(x: x, y: y, width: size, height: size))
            self.layer.cornerRadius = size/2
            self.isCircle = true
        default:
            super.init(frame: CGRect(x: x, y: y, width: size, height: size))
        }
        
        self.backgroundColor = generateRandomColor()
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return (self.isCircle == true) ? .ellipse : .rectangle
    }
    
    func generateRandomColor() -> UIColor {
        return UIColor(red:   CGFloat(arc4random()) / CGFloat(UInt32.max),
                       green: CGFloat(arc4random()) / CGFloat(UInt32.max),
                       blue:  CGFloat(arc4random()) / CGFloat(UInt32.max),
                       alpha: 1.0)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func createRectangle() {
//        // Initialize the path.
//        path = UIBezierPath()
//
//        // Specify the point that the path should start get drawn.
//        path.move(to: CGPoint(x: 0.0, y: 0.0))
//
//        // Create a line between the starting point and the bottom-left side of the view.
//        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
//
//        // Create the bottom line (bottom-left to bottom-right).
//        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
//
//        // Create the vertical line from the bottom-right to the top-right side.
//        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
//
//        // Close the path. This will create the last line automatically.
//        path.close()
//    }
//
    


    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
////        self.createRectangle()
//        let radius = min(bounds.size.width, bounds.size.height) / 2.0
//        self.path = UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
//        // Specify the fill color and apply it to the path.
//        UIColor.orange.setFill()
//        path.fill()
//        // Specify a border (stroke) color.
//        UIColor.purple.setStroke()
//        path.stroke()
//    }


}
