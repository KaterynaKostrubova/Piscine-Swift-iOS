//
//  ViewController.swift
//  d06
//
//  Created by Kateryna KOSTRUBOVA on 4/9/19.
//  Copyright © 2019 Kateryna KOSTRUBOVA. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var behaviorItem: UIDynamicItemBehavior!

    let motionManager =  CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior(items: [])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        behaviorItem = UIDynamicItemBehavior(items: [])
        behaviorItem.elasticity = 0.4
        animator.addBehavior(behaviorItem)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            let queue = OperationQueue.main
            motionManager.startAccelerometerUpdates(to: queue, withHandler: accelerometerHandler)
        }
        else {
            print("accelerometer is not available")
        }
    }
    
    func accelerometerHandler(data: CMAccelerometerData?, error: Error?) {
        if let accelerometerData = data {
            let x = CGFloat(accelerometerData.acceleration.x);
            let y = CGFloat(accelerometerData.acceleration.y);
            let v = CGVector(dx: x, dy: -y);
            gravity.gravityDirection = v;
        }
    }
    
    
    @objc func panGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            self.gravity.removeItem(gesture.view!)
        case .changed:
//            print("move")
            let location = gesture.location(in: view) // root view
            gesture.view?.center = location
            animator.updateItem(usingCurrentState: gesture.view!)
        case .ended:
            self.gravity.addItem(gesture.view!)
        case .failed, .cancelled:
             print("Failed or cancelled")
        case .possible:
            print("Possible")
        }
    }
    
    @objc func pinchItem(pinch: UIPinchGestureRecognizer) {
            switch pinch.state {
            case .began:
                self.gravity.removeItem(pinch.view!)
                self.collision.removeItem(pinch.view!)
                self.behaviorItem.removeItem(pinch.view!)
                animator.updateItem(usingCurrentState: pinch.view!)
                self.collision.addItem(pinch.view!)
                self.behaviorItem.addItem(pinch.view!)
            case.changed:
//                print("scale")
                let width = pinch.view?.layer.bounds.size.width
                if (pinch.scale < 1 || width! <= UIScreen.main.bounds.width) {
                    if let circle = pinch.view! as? Shape {
                        if (circle.isCircle) {
                            pinch.view!.layer.cornerRadius *= pinch.scale
                        }
                    }
                    pinch.view?.layer.bounds.size.height *= pinch.scale
                    pinch.view?.layer.bounds.size.width *= pinch.scale
                    pinch.scale = 1
                }
                self.collision.removeItem(pinch.view!)
                self.behaviorItem.removeItem(pinch.view!)
                animator.updateItem(usingCurrentState: pinch.view!)
                self.collision.addItem(pinch.view!)
                self.behaviorItem.addItem(pinch.view!)
            case .ended:
                self.gravity.addItem(pinch.view!)
            case .failed, .cancelled:
                print("Failed or cancelled")
            case .possible:
                print("Possible")
            }
}
    
    
    @objc func rotateItem(rotate: UIRotationGestureRecognizer) {
        switch rotate.state {
        case .began:
            self.gravity.removeItem(rotate.view!)
            self.collision.removeItem(rotate.view!)
            self.behaviorItem.removeItem(rotate.view!)
            animator.updateItem(usingCurrentState: rotate.view!)
            self.collision.addItem(rotate.view!)
            self.behaviorItem.addItem(rotate.view!)
        case .changed:
//            print("rotate")
            if let view = rotate.view {
                view.transform = view.transform.rotated(by: rotate.rotation)
                rotate.rotation = 0
            }
            self.collision.removeItem(rotate.view!)
            self.behaviorItem.removeItem(rotate.view!)
            animator.updateItem(usingCurrentState: rotate.view!)
            self.collision.addItem(rotate.view!)
            self.behaviorItem.addItem(rotate.view!)
        case .ended:
            self.gravity.addItem(rotate.view!)
        case .failed, .cancelled:
            print("Failed or cancelled")
        case .possible:
            print("Possible")
        }
    }


    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {

        let gpoint = sender.location(in: self.view)
        let shapeView = Shape(point: gpoint, maxwidth: self.view.bounds.width, maxheight: self.view.bounds.height)
        self.view.addSubview(shapeView)
        gravity.addItem(shapeView)
        collision.addItem(shapeView)
        behaviorItem.addItem(shapeView)
        
        let gesture = UIPanGestureRecognizer(target:self, action: #selector(panGesture))
        shapeView.addGestureRecognizer(gesture)

        let pinch = UIPinchGestureRecognizer(target:self, action: #selector(pinchItem))
        shapeView.addGestureRecognizer(pinch)

        let rotation = UIRotationGestureRecognizer(target:self, action: #selector(rotateItem))
        shapeView.addGestureRecognizer(rotation)

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

