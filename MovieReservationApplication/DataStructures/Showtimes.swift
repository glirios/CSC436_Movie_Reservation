//
//  Showtimes.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 11/28/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import Foundation

struct Showtimes: Codable {
    var barg : Int
    var dateTime : String
    var theatre : Theatre
    
    private enum CodingKeys : String, CodingKey {
        case barg
        case dateTime
        case theatre
    }
}
