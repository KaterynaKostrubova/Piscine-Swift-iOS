//
//  ViewController.swift
//  ex02
//
//  Created by Kateryna KOSTRUBOVA on 4/1/19.
//  Copyright © 2019 Kateryna KOSTRUBOVA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var dispRes: UILabel!
    var screenNumber: Double = 0;
    var firstNum: Double = 0;
    var operation: Int = 0;
    var sign: Bool = true;
    var notNum: String = ""
    
    @IBAction func numberPress(_ sender: UIButton) {
        if sign == true {
            dispRes.text = String(sender.tag)
            sign = false
        }
        else {
            dispRes.text = dispRes.text! + String(sender.tag)
            if Double(dispRes.text!)! > Double(Int.max) {
                dispRes.text = "Max Int"
                sign = true
            }
        }
        if sign == false{
            screenNumber = Double(dispRes.text!)!
        }
        print(sender.tag)
    }
    
    @IBAction func pressAction(_ sender: UIButton) {
        let action = sender.currentTitle!
        print(action);
        
        if sender.tag != 10 && sender.tag != 11 && sender.tag != 16 && dispRes.text != "Max Int" && dispRes.text != "Min Int" {
            if dispRes.text == "Not a number" || dispRes.text == "Max Int" || dispRes.text == "Min Int" {
                notNum = "Not a number";
            } else  if dispRes.text != "+" && dispRes.text != "-" && dispRes.text != "×" && dispRes.text != "÷"{
                firstNum = Double(dispRes.text!)!
            }
            if sender.tag == 12 {
                dispRes.text = "+";
            }
            else if sender.tag == 13 {
                dispRes.text = "×";
            }
            else if sender.tag == 14 {
                dispRes.text = "-";
            }
            else if sender.tag == 15 {
                dispRes.text = "÷";
            }
            operation = sender.tag
        }
        else if sender.tag == 16 {
            if notNum == "Not a number" || dispRes.text == "Max Int" || dispRes.text == "Min Int" {
                dispRes.text = "Not a number"
            } else if operation == 12 {
                if Double(firstNum + screenNumber) > Double(Int.max) {
                    dispRes.text = "Max Int"
                } else if Double(firstNum + screenNumber) < Double(Int.min) {
                    dispRes.text = "Min Int"
                } else {
                    dispRes.text = String(Int(firstNum + screenNumber))
                }
            }
            else if operation == 13 {
                if Double(firstNum * screenNumber) > Double(Int.max) {
                    dispRes.text = "Max Int"
                } else if Double(firstNum * screenNumber) < Double(Int.min) {
                    dispRes.text = "Min Int"
                } else {
                    dispRes.text = String(Int(firstNum * screenNumber))
                }
            }
            else if operation == 14 {
                if Double(firstNum - screenNumber) < Double(Int.min) {
                    dispRes.text = "Min Int"
                } else if Double(firstNum - screenNumber) > Double(Int.max) {
                    dispRes.text = "Max Int"
                } else {
                    dispRes.text = String(Int(firstNum - screenNumber))
                }
            }
            else if operation == 15 {
                if screenNumber == 0 {
                    dispRes.text = "Not a number"
                } else if Double(firstNum / screenNumber) < Double(Int.min) {
                    dispRes.text = "Min Int"
                } else {
                    dispRes.text = String(Int(firstNum / screenNumber))
                }
            }
        }
        else if sender.tag == 10 {
            dispRes.text = "0"
            firstNum = 0
            screenNumber = 0
            operation = 0
            notNum = ""

        }
        else if sender.tag == 11 && dispRes.text != "0" && dispRes.text != "Not a number" &&
                dispRes.text != "Max Int" && dispRes.text != "Min Int" && dispRes.text != "+" &&
                dispRes.text != "-" && dispRes.text != "×" && dispRes.text != "÷" && Int(dispRes.text!)! > 0 {
                dispRes.text = String(0 - Int(dispRes.text!)!)
                screenNumber = Double(dispRes.text!)!
        }
        sign = true;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

