//
//  MovieAPI.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 11/30/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import Foundation

class MovieAPI {
    private var Moviekey = "fa4yd8erkydjmhdevq6zb8rz"

    
    //http://data.tmsapi.com/v1.1/movies/showings?startDate=2017-11-30&numDays=2&zip=93405&lat=40.741895&lng=-73.989308&radius=25&imageSize=Sm&api_key=fa4yd8erkydjmhdevq6zb8rz

    func getMoviesPlayingLocally(startDate:String, numDays:String = "1", zip:String, lat: String = "800", lng: String = "800", radius: String = "5") -> [Movies] {
        var days : String
        var coordinatesSet = false
        var date : String
        let base = "http://data.tmsapi.com/v1.1/movies/showings?"
        if Double(lat) != 800 && Double(lng) != 800 {
            coordinatesSet = true
        }
        
        days = numDays
        
        if startDate != "" {
            self.startDate = startDate
        } else {
            self.startDate = getDate()
        }
        self.radius = radius

        
    }
    
    // Pulls the correct date for the date
    func getDate() -> String {
        let date = Date()
        let cal = Calendar.current
        
        let year = cal.component(.year, from: date)
        let month = cal.component(.month, from: date)
        let day = cal.component(.day, from: date)
        
        return "\(year)-\(month)-\(day)"
    }
}
