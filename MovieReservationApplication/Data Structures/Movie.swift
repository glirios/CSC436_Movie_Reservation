//
//  Movie.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 11/11/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import Foundation

class Movie {
    var movie: String
    var runTime: String
    var rating: String
    var releaseDate: String
    
    init(movie: String, runTime: String, rating: String, releaseDate: String) {
        self.movie = movie
        self.runTime = runTime
        self.rating = rating
        self.releaseDate = releaseDate
    }
    
}
