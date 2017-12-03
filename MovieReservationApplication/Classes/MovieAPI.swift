//
//  MovieAPI.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 11/30/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import Foundation

class MovieAPI {
    var movieData : [Movies]?
    private var Moviekey = "api_key=fa4yd8erkydjmhdevq6zb8rz"
    let ampersand = "&"
    let numDaysSring = "numDays="
    let startDateString = "startDate="
    let zipString = "zip="
    let latString = "lat="
    let lngString = "lng="
    let radiusString = "radius="
    let imageString = "imageSize=Sm"
    
    //http://data.tmsapi.com/v1.1/movies/showings?startDate=2017-12-2&numDays=2&zip=93405&lat=40.741895&lng=-73.989308&radius=25&imageSize=Sm&api_key=fa4yd8erkydjmhdevq6zb8rz
    //http://data.tmsapi.com/v1.1/movies/showings?startDate=2017-12-2&numDays=2&zip=93405&radius=10&imageSize=Sm&api_key=fa4yd8erkydjmhdevq6zb8rz
    // Pulls the correct date for the date
    func getDate() -> String {
        let date = Date()
        let cal = Calendar.current
        
        let year = cal.component(.year, from: date)
        let month = cal.component(.month, from: date)
        let day = cal.component(.day, from: date)
        
        return "\(year)-\(month)-\(day)"
    }
    
    func getMoviesPlayingLocally(startDate:String, numDays:String = "1", zip:String, lat: String = "800", lng: String = "800", radius: String = "5") -> [Movies] {
        var urlString : String = "http://data.tmsapi.com/v1.1/movies/showings?"
        if startDate != "" {
            urlString = urlString + startDateString + startDate
        } else {
            urlString = urlString + startDateString + self.getDate()
        }
        
        urlString = urlString + ampersand + numDaysSring + numDays
        
        if Double(lat) != 800 && Double(lng) != 800 {
            urlString = urlString + ampersand + latString + lat + ampersand + lngString + lng
        }
        else {
            urlString = urlString + ampersand + zipString + zip
        }
        
        urlString = urlString + ampersand + radiusString + radius + ampersand + imageString + ampersand + Moviekey

        print(urlString)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: URL(string: urlString)!)
        let task : URLSessionDataTask = session.dataTask(with: request)
            { (receivedData, response, error) -> Void in
            
            if let data = receivedData {
                
                do {
                    print("here too")
                    let decoder = JSONDecoder()
                    self.movieData = try decoder.decode([Movies].self, from: data)
                    print("here")
                    for data in self.movieData! {
                        print(data.title
                        )
                    }
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task.resume()
        return self.movieData!
    }

}
