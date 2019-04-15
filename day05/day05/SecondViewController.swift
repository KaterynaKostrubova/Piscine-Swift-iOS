//
//  SecondViewController.swift
//  day05
//
//  Created by Kateryna KOSTRUBOVA on 4/8/19.
//  Copyright © 2019 Kateryna KOSTRUBOVA. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tabView: UITableView!{
        didSet {
            tabView.delegate = self
            tabView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.reloadData()
    }

    func tableView(_ tabView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return (Place.locations.count)
    }
    
    func tableView(_ tabView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabView.dequeueReusableCell(withIdentifier: "place", for: indexPath)
        cell.textLabel?.text = Place.locations[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Place.curLocation = Place.locations[indexPath.row]
        print(indexPath.row)
        DispatchQueue.main.async {
            self.performSegue(withIdentifier : "showMap", sender: Any?.self)
        }
    }
    
    func numberOfSections(in tabView: UITableView) -> Int {
        return 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

