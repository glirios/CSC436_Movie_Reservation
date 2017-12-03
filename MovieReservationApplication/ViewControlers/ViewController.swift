//
//  ViewController.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 11/9/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//
// Fandango API KEY 6c4x5kgcddwutw9u726sutey  Secret: RFJqwntuHa
import UIKit

class ViewController: UIViewController {

    let moviesCall = "https://data.tmsapi.com/v1.1/movies/showings?startDate=2017-11-30&zip=93405&api_key=fa4yd8erkydjmhdevq6zb8rz"
    var movieData : [Movies]?
    var API = MovieAPI()
    var date : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: URL(string: moviesCall)!)
        let task: URLSessionDataTask = session.dataTask(with: request) { (receivedData, response, error) -> Void in

            if error == nil, let data = receivedData {

                // uncomment to print raw response
                let rawDataString = String(data: data, encoding: String.Encoding.utf8)
                print(rawDataString!)
            }
        }
        task.resume()
        let request2 = URLRequest(url: URL(string: reviewsCall)!)
        let task2: URLSessionDataTask = session.dataTask(with: request2) { (receivedData, response, error) -> Void in


            if let data = receivedData {

                // uncomment to print raw response
                let rawDataString = String(data: data, encoding: String.Encoding.utf8)
                print(rawDataString!)
            }
        }
        task2.resume()
      
      
        
    }

    func jsonDrillDown(json : Any, indent: String) {
        let ourIndent = indent + "\t"  
            if let data = receivedData {
                do {
                    
                    let decoder = JSONDecoder()
                    let array = try decoder.decode([Movies].self, from: data)
//                    for item in array {
//                        print(item.genres)
//                        print(item.title)
//                        print(item.directors)
//                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

