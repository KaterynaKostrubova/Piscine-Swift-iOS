//
//  ViewController.swift
//  day04
//
//  Created by Kateryna KOSTRUBOVA on 4/6/19.
//  Copyright © 2019 Kateryna KOSTRUBOVA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, APITwitterDelegate, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func receiveTweets(tweets: [Tweet]) {
        self.tweets = tweets
        tableView.reloadData()
    }
    
    func errorTweets(error: NSError) {
        print(error)
    }
    
    var tweets: [Tweet] = []
    var token: String = ""
    let query:String = "&src=typd&lang=fr&count=100&result_type=recent"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let CUSTOMER_KEY = "TQrY2wPa1nJS4A15f78q5Q0Q8"
        let CUSTOMER_SECRET = "4TekrHmLJ71uVcm2GIHIoyhKgdXGtkrphNGn536Zl1wTrtDoqR"
        let BEARER = ((CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString()
        
        let url = NSURL(string: "https://api.twitter.com/oauth2/token")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;CHARSET=UTF-8", forHTTPHeaderField: "Content-type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(error!)
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
//                        print(dic)
                        for (key, value) in dic {
                            if key as! String == "access_token" {
                                self.token = value as! String
//                                print(self.token)
                            }
                        }
                        let controller = APIController(delegate: self, token: self.token)
                        controller.getTweets(search: "q=" + "school 42".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + self.query)
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcell") as! TableViewCell
        cell.name.text = tweets[indexPath.row].name
        cell.name?.numberOfLines = 0
        cell.date?.numberOfLines = 0
        cell.tweet?.numberOfLines = 0
        cell.date.text = tweets[indexPath.row].date
        cell.tweet.text = tweets[indexPath.row].text
//        cell.name.text = "1"
//        cell.date.text = "2"
//        cell.tweet.text = "3"

        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

