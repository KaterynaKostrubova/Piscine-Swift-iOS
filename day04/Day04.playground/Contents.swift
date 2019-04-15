//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let CUSTOMER_KEY = "TQrY2wPa1nJS4A15f78q5Q0Q8"
let CUSTOMER_SECRET = "4TekrHmLJ71uVcm2GIHIoyhKgdXGtkrphNGn536Zl1wTrtDoqR"
let BEARER = ((CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
//let url = NSURL(string: "https://api.twitter.com/oauth2/token")
let request = NSMutableURLRequest(url: NSURL(string: "https://api.twitter.com/oauth2/token") as! URL)
request.httpMethod = "Post"
request.setValue("Basic" + BEARER, forHTTPHeaderField: "Authorization")
request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
request.httpBody = "grand_type=client_credentials".data(using: String.Encoding.utf8)
let task = URLSession.sharedSession().dataTaskWithRequest(request){
    data, response, error in
    print(response)
    if let err = error {
        print(error)
    }
    else if let d = data {
        do {
            if let dic : NSDictionary = try NSJSONSeriolization.JSONObjectWithData(d, options: NSJSONReadingOptions.MutableContainers) as NSDictionary {
                print(dic)
            }
        }
        catch (let err){
            print(err)
        }
    }
}
//task.resume()
//XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

