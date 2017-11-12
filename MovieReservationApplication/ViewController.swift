//
//  ViewController.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 11/9/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//
// Fandango API KEY 6c4x5kgcddwutw9u726sutey  Secret: RFJqwntuHa
import UIKit
import EventKit

class ViewController: UIViewController {

    let moviesCall = "https://data.tmsapi.com/v1.1/movies/showings?startDate=2017-11-10&zip=93405&api_key=fa4yd8erkydjmhdevq6zb8rz"
    let reviewsCall = "https://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=6c4x5kgcddwutw9u726sutey"
    var calendar : Calendar?
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//        let request = URLRequest(url: URL(string: moviesCall)!)
//        let task: URLSessionDataTask = session.dataTask(with: request) { (receivedData, response, error) -> Void in
//
//
//            if let data = receivedData {
//
//                // uncomment to print raw response
//                let rawDataString = String(data: data, encoding: String.Encoding.utf8)
//                print(rawDataString!)
//            }
//        }
//        task.resume()
//        let request2 = URLRequest(url: URL(string: reviewsCall)!)
//        let task2: URLSessionDataTask = session.dataTask(with: request2) { (receivedData, response, error) -> Void in
//
//
//            if let data = receivedData {
//
//                // uncomment to print raw response
//                let rawDataString = String(data: data, encoding: String.Encoding.utf8)
//                print(rawDataString!)
//            }
//        }
//        task2.resume()
        
    }

    func jsonDrillDown(json : Any, indent: String) {
        let ourIndent = indent + "\t"
        
        if json is Dictionary<String,Any> {
            let dict = json as! Dictionary<String,Any>
            for (key, value) in dict {
                if value is Dictionary<String, Any> {
                    print("\(ourIndent)\(key) is a dictionary ->")
                    jsonDrillDown(json: value, indent: ourIndent)
                } else if value is Array<Any> {
                    let array = value as! Array<Any>
                    let first = array.first
                    if first is Dictionary<String,Any> {
                        print("\(ourIndent)\(key) array -> type is a dictionary ->")
                        jsonDrillDown(json: first!, indent: ourIndent)
                    }
                } else {
                    //print("\(ourIndent)\(key) : \(type (of: value))")
                    print("\(ourIndent)\(key) : " + convertToSwiftName(value: value))
                }
            }
        } else {
            //print("\(ourIndent)type: \(type (of: json))")
            print("\(ourIndent)type: " + convertToSwiftName(value: json))
        }
    }
    
    func convertToSwiftName(value : Any) -> String {
        switch value {
        case is NSString:
            return "String"
        case is NSNumber:
            return "Number"
        case is NSNull:
            return "Null"
        default:
            return "****** something else! (type(of: value))"
        }
    }

}

