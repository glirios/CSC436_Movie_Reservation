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

    @IBOutlet weak var imageDownload: UIImageView!
    let moviesCall = "https://data.tmsapi.com/v1.1/movies/MV009897380000/showings?startDate=2017-12-03&zip=93405&api_key=fa4yd8erkydjmhdevq6zb8rz"
    var movieData : [Movies]?
    var API = MovieAPI()
    var date : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Getting API Date format")
        print(API.getDate())
//        API.getMoviesPlayingLocally(startDate: "", zip: "93405", lat: "", lng: "") { movies in
//            self.movieData = movies
//            print(self.movieData?.count)
//        }
//        print(movieData?.count)
        

//        API.getMovieShowtimes(startDate: "", zip: "93405", lat: "", lng: "", movieId: "MV009897380000") { showtimes in
//            for movie in showtimes {
//                let title = movie.title
//                for times in movie.showtimes {
//                    print(title + " is playing at " + times.theatre.name + " at " + times.dateTime)
//                }
//            }
//        }
        
//        API.getTheatreDetails(theatreId: "8749") { theatre in
//            print(theatre)
//        }
        
        API.getTheatres(zip: "93405", lat: "", lng: "", radius: "25") { theatres in
            for theatre in theatres {
                print(theatre.name)
                print(theatre.id)
            }
        }
//        while (movieData == nil) {
//            print("waiting")
//        }
//        print("done waiting")
//
//        DispatchQueue.global(qos: .userInitiated).async {
//
//            let url = URL(string: "http://tmsimg.com/" + (self.movieData?.first?.imageURL.URL)!)
//            print(url)
//            let responseData = try? Data(contentsOf: url!)
//            let downloadedImage = UIImage(data: responseData!)
//
//            DispatchQueue.main.async {
//                self.imageDownload.image = downloadedImage
//            }
//
//        }
        
        
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//        let request = URLRequest(url: URL(string: moviesCall)!)
//        let task: URLSessionDataTask = session.dataTask(with: request) { (receivedData, response, error) -> Void in
//
//            if let data = receivedData {
//                do {
//                    print("session started")
//                    let decoder = JSONDecoder()
//                    let array = try decoder.decode([Movies].self, from: data)
//                    print("data pulled")
//                    print(array.count)
//                    for movie in array {
//                        print(movie.title)
//                    }
//
//                } catch {
//                    print("Exception on Decode: \(error)")
//                }
//            }
//        }
//        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

