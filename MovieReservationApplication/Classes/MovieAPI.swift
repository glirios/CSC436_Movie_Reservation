//
//  MovieAPI.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 11/30/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import Foundation

class MovieAPI {
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
    
    //http://data.tmsapi.com/v1.1/theatres?zip=93405&lat=35.2827524&lng=-120.6596156&radius=25&api_key=fa4yd8erkydjmhdevq6zb8rz
    func getTheatres(zip:String, lat: String, lng: String, radius: String = "5", completionHandler: @escaping ([Theatres]) -> Void) {
        
        var urlString : String = "https://data.tmsapi.com/v1.1/theatres?"
        
        if lat != "" && lng != "" {
            urlString = urlString + ampersand + latString + lat + ampersand + lngString + lng
        }
        else {
            urlString = urlString + ampersand + zipString + zip
        }
        
        urlString = urlString + ampersand + radiusString + radius + ampersand + Moviekey
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: URL(string: urlString)!)
        let task : URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            
            if let data = receivedData {
                
                do {
                    let decoder = JSONDecoder()
                    let theatres = try decoder.decode([Theatres].self, from: data)
                    for data in theatres {
                        print(data.name)
                    }
                    completionHandler(theatres)
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task.resume()
    }
    
    //http://data.tmsapi.com/v1.1/theatres/8749?api_key=fa4yd8erkydjmhdevq6zb8rz
    func getTheatreDetails(theatreId : String, completionHandler: @escaping (Theatre) -> Void) {
        
        var urlString : String = "https://data.tmsapi.com/v1.1/theatres/" + theatreId + "?"
        
        urlString = urlString + Moviekey
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: URL(string: urlString)!)
        let task : URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            
            if let data = receivedData {
                
                do {
                    let decoder = JSONDecoder()
                    let theatre = try decoder.decode(Theatre.self, from: data)
                    completionHandler(theatre)
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task.resume()
    }
    
    
    //http://data.tmsapi.com/v1.1/theatres/7486/showings?startDate=2017-12-03&numDays=1&imageSize=Sm&api_key=fa4yd8erkydjmhdevq6zb8rz
    func getShowingsByTheatre(startDate:String, numDays:String = "1", theatreId : String, completionHandler: @escaping ([Movies]) -> Void) {
        
        var urlString : String = "https://data.tmsapi.com/v1.1/theatres/" + theatreId + "/showings?"
        
        if startDate != "" {
            urlString = urlString + startDateString + startDate
        } else {
            urlString = urlString + startDateString + self.getDate()
        }
        
        urlString = urlString + ampersand + numDaysSring + numDays
        urlString = urlString + ampersand + imageString + ampersand + Moviekey
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: URL(string: urlString)!)
        let task : URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            
            if let data = receivedData {
                
                do {
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode([Movies].self, from: data)

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
    
    
    // http://data.tmsapi.com/v1.1/movies/MV009897380000/showings?startDate=2017-12-03&numDays=2&zip=93405&lat=35.2827524&lng=-120.6596156&radius=25&imageSize=Sm&api_key=fa4yd8erkydjmhdevq6zb8rz
    func getMovieShowtimes(startDate:String, numDays:String = "1", zip:String, lat: String, lng: String, radius: String = "5", movieId: String, completionHandler: @escaping ([Showtimes]) -> Void) {
        
        var urlString : String = "http://data.tmsapi.com/v1.1/movies/"  + movieId + "/showings?"
        
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
                    let decoder = JSONDecoder()
                    let showtimes = try decoder.decode([Showtimes].self, from: data)
                    completionHandler(showtimes)
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task.resume()
    }
    
    
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
