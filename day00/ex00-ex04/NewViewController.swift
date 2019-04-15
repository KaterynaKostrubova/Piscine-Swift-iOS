//
//  NewViewController.swift
//  ex02
//
//  Created by Kateryna KOSTRUBOVA on 4/1/19.
//  Copyright © 2019 Kateryna KOSTRUBOVA. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBAction func click(_ sender: UIButton) {
        if (statusLabel.text == "Hello World !") {
            statusLabel.text = "Hello Swift !!!!!!!!!!!!!!"
        } else {
            statusLabel.text = "Hello World !"
        }
        print ("Hello world !")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
