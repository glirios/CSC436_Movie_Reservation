//
//  Movies.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 11/11/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import Foundation

struct Movies : Codable {
    var id : String  //tmsID
    var genres: [String]
    var releaseDate: String
    var imageURL : URLPicker
    var officialURL : URL
    var runTime : String
    var showtimes : [Showtimes]
    var synopsis : String //Long Description
    var leadCast : [String]
    var ratings : [Ratings]
    var directors : [String]
    var title: String
    
    private enum CodingKeys : String, CodingKey {
        case id = "tmsId"
        case genres
        case releaseDate
        case imageURL = "preferredImage" //needs codable enum
        case officialURL = "officialUrl"
        case runTime
        case synopsis = "longDescription"
        case leadCast = "topCast"
        case ratings
        case directors
        case title
        case showtimes
    }
    
    struct URLPicker : Codable {
        var URL : String
        private enum CodingKeys : String, CodingKey {
            case URL = "uri"  // needs developer.tmsimg.com
        }
    }
    

    struct Showtimes : Codable {
        var theatre : Theatre
        var dateTime : String
        var barg : Int
        
        private enum CodingKeys : String, CodingKey {
            case theatre
            case dateTime
            case barg
        }
        
        struct Theatre : Codable {
            var id : String
            var name : String
            
            private enum CodingKeys : String, CodingKey {
                case id
                case name
            }
        }
    }
    
    struct Ratings : Codable {
        var code : String
        
        private enum CodingKeys : String, CodingKey {
            case code
        }
    }
}
