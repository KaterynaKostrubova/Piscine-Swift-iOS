//
//  SecondViewController.swift
//  day02
//
//  Created by Kateryna KOSTRUBOVA on 4/3/19.
//  Copyright © 2019 Kateryna KOSTRUBOVA. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var bigTextField: UITextView!
    @IBOutlet weak var myDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tapButton(){
        if (myTextField.text! != ""){
            let name = String(myTextField.text!)
            let description = String(bigTextField.text!)
            let deathDate = myDate.date
            let dateFormatter = DateFormatter()

            dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
            let myStringafd = dateFormatter.string(from: deathDate)
            Data.persons.append((name, description, myStringafd))
            self.navigationController?.popViewController(animated: true)
        }
    }
}
