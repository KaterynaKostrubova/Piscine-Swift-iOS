//
//  ViewController.swift
//  day02
//
//  Created by Kateryna KOSTRUBOVA on 4/3/19.
//  Copyright © 2019 Kateryna KOSTRUBOVA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var persons = Data.persons
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "death") as! PersonTableViewCell
        
        cell.person = Data.persons[indexPath.row]
        cell.descrLabel?.numberOfLines = 0
        cell.nameLabel?.numberOfLines = 0
        cell.yearLabel?.numberOfLines = 0
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVc = segue.destination as? SecondViewController

        destVc?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: destVc!, action: #selector(destVc?.tapButton))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

