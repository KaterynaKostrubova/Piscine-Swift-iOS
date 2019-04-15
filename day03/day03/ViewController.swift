//
//  ViewController.swift
//  day03
//
//  Created by Kateryna KOSTRUBOVA on 4/5/19.
//  Copyright © 2019 Kateryna KOSTRUBOVA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
        
    
    let images: [URL] = [
    
        URL(string: "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/iss059e006522.jpg")!,
        URL(string: "https://basik.ru/images/photo_wallpapers/7047ac8ea47c4e2bbcda1eaeb79a3221_big.png")!,
        URL(string: "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/nick.jpg")!,
        URL(string: "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/46713638424_0f32acec3f_k.jpg")!,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImagesCollectionViewCell
        
        cell.spinner(shouldSpin: true)
        URLSession.shared.dataTask(with: images[indexPath.item]) { (data, response, error) in
        if error != nil {
            let alert = UIAlertController(title: "Error", message: "Cannot acces to " + self.images[indexPath.item].absoluteString, preferredStyle: .alert)
            let action1 = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action1)
            self.present(alert, animated: true, completion: nil)
            return
            }
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data!)
                cell.spinner(shouldSpin: false)
            }
        }.resume()
    
//        cell.layer.borderColor = UIColor.lightGray.cgColor
//        cell.layer.borderWidth = 0.5
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! ImagesCollectionViewCell
        let destVC = segue.destination as! scrollCollectionViewCell
        destVC.image = cell.imageView.image
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        performSegue(withIdentifier: "ShowImg", sender: cell)
    }
    
}

