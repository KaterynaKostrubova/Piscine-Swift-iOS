//
//  ViewController.swift
//  day07
//
//  Created by Kateryna KOSTRUBOVA on 4/10/19.
//  Copyright © 2019 Kateryna KOSTRUBOVA. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO

class ViewController: UIViewController, UITextFieldDelegate {
    
    var bot : RecastAIClient?
    var darkSky: DarkSkyClient?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bot = RecastAIClient(token: Constants.tokenRecast, language: "en")
        self.darkSky = DarkSkyClient(apiKey: Constants.tokenDarkSky)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var response: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    func sendRequest(request: String){
        bot?.textRequest(textField.text!, successHandler: { (response) in
            if let location = response.all(entity: "location") {
                let loc = (location[0]["formatted"] as? String, location[0]["lat"]?.doubleValue, location[0]["lng"]?.doubleValue)
                self.darkSky?.getForecast(latitude: loc.1!, longitude: loc.2!, completion: { result in
                    switch result {
                        case .success(let currentForecast, _):
                            DispatchQueue.main.async {
                                self.response.text = "\(currentForecast.currently!.summary!)"
                            }
                    case .failure:
                        self.response.text = "Error"
                    }
                })
            } else {
                self.response.text = "Enter a valid city"
            }
        }, failureHandle: { (error) in
            self.response.text = "Error"
        })
    }
    

    @IBAction func makeRequest(_ sender: UIButton) {
        if (textField.text != nil && textField.text != "") {
            self.sendRequest(request: textField.text!)
        }
    }
}

