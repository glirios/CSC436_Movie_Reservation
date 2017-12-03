//
//  MovieAPI.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 11/30/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import Foundation

class MovieAPI {
    var movieDataAPI : [Movies]?
    private var Moviekey = "api_key=fa4yd8erkydjmhdevq6zb8rz"
    let ampersand = "&"
    let numDaysSring = "numDays="
    let startDateString = "startDate="
    let zipString = "zip="
    let latString = "lat="
    let lngString = "lng="
    let radiusString = "radius="
    let imageString = "imageSize=Sm"
    

    // Pulls the correct date for the date
    func getDate() -> String {
        let date = Date()
        let cal = Calendar.current
        
        let year = cal.component(.year, from: date)
        let month = cal.component(.month, from: date)
        let day = cal.component(.day, from: date)
        
        return "\(year)-\(month)-\(day)"
    }
    
    
    func 
    
    
    //http://data.tmsapi.com/v1.1/movies/showings?startDate=2017-12-2&numDays=2&zip=93405&lat=40.741895&lng=-73.989308&radius=25&imageSize=Sm&api_key=fa4yd8erkydjmhdevq6zb8rz
    func getMoviesPlayingLocally(startDate:String, numDays:String = "1", zip:String, lat: String, lng: String, radius: String = "5", completionHandler: @escaping ([Movies]) -> Void) {
        
        var urlString : String = "https://data.tmsapi.com/v1.1/movies/showings?"

        if startDate != "" {
            urlString = urlString + startDateString + startDate
        } else {
            urlString = urlString + startDateString + self.getDate()
        }
        
        urlString = urlString + ampersand + numDaysSring + numDays
        
        if lat != "" && lng != "" {
            urlString = urlString + ampersand + latString + lat + ampersand + lngString + lng
        }
        else {
            urlString = urlString + ampersand + zipString + zip
        }
        
        urlString = urlString + ampersand + radiusString + radius + ampersand + imageString + ampersand + Moviekey
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: URL(string: urlString)!)
        let task : URLSessionDataTask = session.dataTask(with: request)
            { (receivedData, response, error) -> Void in
            
            if let data = receivedData {
                
                do {
                    print("here")
                    let decoder = JSONDecoder()
                    print("before decoding")
                    let movies = try decoder.decode([Movies].self, from: data)
                    print("after decoding")
                    for data in movies {
                        print(data.title)
                    }
                    completionHandler(movies)
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task.resume()
    }

}
