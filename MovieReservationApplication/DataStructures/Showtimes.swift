//
//  Showtimes.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 11/28/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import Foundation

struct Showtimes: Codable {
    var showtimes : [Times]
    var title : String
    var id : String
    private enum CodingKeys : String, CodingKey {
        case showtimes
        case title
        case id = "tmsId"
    }
    
    struct Times : Codable {
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
}
