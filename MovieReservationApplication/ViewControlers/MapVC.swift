//
//  MapVC.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 12/4/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var zipcode: UITextField!
    
    
    
    
    var API = MovieAPI()
    var points = [MapLocation]()
    var txt : String?
    let manager = CLLocationManager()
    var userLocation : CLLocation?
    var userCoord : CLLocationCoordinate2D?
    let geocoder = CLGeocoder()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
//        managerConfiguration()
    }

//    func managerConfiguration() {
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
//        manager.requestAlwaysAuthorization()
//        manager.startUpdatingLocation()
//    }
    
    @IBAction func textFieldPrimaryAction(_ sender: Any) {
        zipcode.resignFirstResponder()
        txt = zipcode.text
        geocoder.geocodeAddressString(txt!) { (placemarks, error) in
            let lat = placemarks?.first?.location?.coordinate.latitude
            let lng = placemarks?.first?.location?.coordinate.longitude
            let coord = CLLocationCoordinate2DMake(lat!, lng!)
            let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            let startRegion = MKCoordinateRegion(center: coord, span: span)
            self.mapView.setRegion(startRegion, animated: true)
        }
        API.getTheatres(zip: txt!, lat: "", lng: "", radius: "25") { theatres in
            self.removeAnnotations()
            self.points = [MapLocation]()
            for theatre in theatres {
                let coord = CLLocationCoordinate2DMake(Double(theatre.location.geoCode.lat)!, Double(theatre.location.geoCode.long)!)
                self.points.append(MapLocation.init(coord: coord, name: theatre.name, detail: String(theatre.location.distance)))
            }
            self.placeAnnotations()
        }
    }
    
    func placeAnnotations() {
        mapView.addAnnotations(points)
    }
    
    func removeAnnotations() {
        mapView.removeAnnotations(points)
    }
    
//    @IBAction func switchMoved(_ sender: Any) {
//        if (GPSswitch.isOn) {
//            while (userCoord == nil) {
//            }
//            userCoord = CLLocationCoordinate2DMake((userLocation?.coordinate.latitude)!, (userLocation?.coordinate.longitude)!)
//            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            let startRegion = MKCoordinateRegion(center: userCoord!, span: span)
//            mapView.setRegion(startRegion, animated: true)
//        }
//    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        self.userLocation = locations[0]
//    }
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
