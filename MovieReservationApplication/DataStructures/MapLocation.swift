//
//  MapLocation.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 12/4/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import Foundation
import MapKit

class MapLocation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coord : CLLocationCoordinate2D, name : String, detail : String) {
        coordinate = coord
        title = name
        subtitle = detail
        super.init()
    }
}
