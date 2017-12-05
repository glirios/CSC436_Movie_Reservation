//
//  Theatre.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 11/29/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import Foundation

// http://data.tmsapi.com/v1.1/theatres/8749?api_key=fa4yd8erkydjmhdevq6zb8rz
struct Theatre : Codable {

    var id : String
    var name : String
    var location : Location
    
    private enum CodingKeys : String, CodingKey {
        case id = "theatreId"
        case name
        case location
    }
    
    struct Location : Codable {
        var geoCode : Coordinates
        var address : Address
        
        private enum CodingKeys : String, CodingKey {
            case geoCode
            case address
        }
        
        
        struct Coordinates : Codable {
            var lat : String
            var long : String
            
            private enum CodingKeys : String, CodingKey {
                case lat = "latitude"
                case long = "longitude"
            }
        }
        
        
        struct Address : Codable {
            var street : String
            var state : String
            var city : String
            var country : String
            var postalCode : String
            
            private enum CodingKeys : String, CodingKey {
                case street
                case state
                case city
                case country
                case postalCode
            }
        }
    }
}
