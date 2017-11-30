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
    let reviewsCall = "https://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=6c4x5kgcddwutw9u726sutey"
    var movieData : [Movies]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: URL(string: moviesCall)!)
        let task: URLSessionDataTask = session.dataTask(with: request) { (receivedData, response, error) -> Void in
            
            if let data = receivedData {
        
                do {
                    
                    let decoder = JSONDecoder()
                    let array = try decoder.decode([Movies].self, from: data)
                    for item in array {
                        print(item.genres)
                        print(item.title)
                        print(item.directors)
                    }
//                    let movieDecoding = try decoder.decode(MovieArray.self, from: data)
//                    print(movieDecoding.array)
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
//                var jsonResponse : [Any]?
//
//                do {
//                    jsonResponse = try JSONSerialization.jsonObject(with: data) as? [Any]
//                }
//                catch {
//                    print("Caught exception")
//                }
//                var iterator = jsonResponse?.makeIterator()
//                print(jsonResponse?.count)
//
//                while let information = iterator?.next() as? [String:Any] {
//                    print(information)
//                }
            }
        }
        task.resume()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

