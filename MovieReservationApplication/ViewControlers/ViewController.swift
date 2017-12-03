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

    let moviesCall = "http://data.tmsapi.com/v1.1/movies/MV005298400000/showings?startDate=2017-12-03&numDays=2&zip=93405&lat=35.299448&lng=-120.689006&radius=5&imageSize=Sm&api_key=fa4yd8erkydjmhdevq6zb8rz"
    var movieData : [Movies]?
    var API = MovieAPI()
    var date : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(API.getDate())
        movieData = API.getMoviesPlayingLocally(startDate: "", numDays: "2", zip: "93405", radius: "10")
        print(movieData?.count)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: URL(string: moviesCall)!)
        let task: URLSessionDataTask = session.dataTask(with: request) { (receivedData, response, error) -> Void in
            
            if let data = receivedData {
        
                do {
                    
                    let decoder = JSONDecoder()
                    let array = try decoder.decode([Movies].self, from: data)
                    
                    for movie in array {
                        print(movie.showtimes)
                    }
                    
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

