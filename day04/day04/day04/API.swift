//
//  API.swift
//  day04
//
//  Created by Kateryna KOSTRUBOVA on 4/6/19.
//  Copyright © 2019 Kateryna KOSTRUBOVA. All rights reserved.
//

import Foundation

protocol APITwitterDelegate : class {
    func receiveTweets (tweets: [Tweet])
    func errorTweets (error: NSError)
}

class APIController {
    weak var delegate : APITwitterDelegate?
    let token : String

    init (delegate: APITwitterDelegate?, token: String) {
        self.delegate = delegate
        self.token = token;
    }

    func getTweets(search: String) {
                let url = NSURL(string: "https://api.twitter.com/1.1/search/tweets.json?" + search)
                let request = NSMutableURLRequest(url: url! as URL)
                request.httpMethod = "GET"
                request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
                let task = URLSession.shared.dataTask(with: request as URLRequest) {
                    (data, response, error) in
//                        print(response!)
                    if let err = error {
                        print(error!)
                    }
                    else if let d = data {
                        do {
                            var tweets: [Tweet] = []
                            if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
//                                print(dic)
                                if let statuses: [NSDictionary] = dic["statuses"] as? [NSDictionary] {
                                    for status in statuses {
                                        let name = (status["user"] as? NSDictionary)?["name"] as? String
                                        let text = status["text"] as? String
                                        let date = status["created_at"] as? String
                                        print(name!)
                                        print(text!)
                                        print(date!)
                                        print("----------")
                                        if (name != nil) && (text != nil) && (date != nil) {
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
                                            if let date = dateFormatter.date(from: date!) {
                                                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                                                let newDate = dateFormatter.string(from: date)
                                                tweets.append(Tweet(name: name!, text: text!, date: newDate))
                                                
                                            }
                                        }
                                    }
                                    DispatchQueue.main.async {
                                        self.delegate?.receiveTweets(tweets: tweets)
                                    }
                                }

                            }
                        }
                        catch (let err) {
                            print(err)
                        }
                    }
                }
                task.resume()
    }
}
