//
//  RouteViewController.swift
//  LocationList
//
//  Created by Ekin Barış Demir on 25.06.2021.
//

import UIKit
import MapKit
import CoreLocation

class RouteViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cancelButton: CustomButton!
    @IBOutlet weak var infoLabel: UILabel!
    var locationManager: CLLocationManager = CLLocationManager()
    var location = Location()
    var userCoor = CLLocation(latitude: 0.0, longitude: 0.0)
    var userLong = Double()
    var userLat = Double()
    var userLocation = CLLocationCoordinate2D()
    var destinationLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupLocationManager()
        cancelButton.layer.cornerRadius = 20
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        drawRoute()
        
    }
    
    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let lastLocation: CLLocation = locations[locations.count-1]
        self.userLong = lastLocation.coordinate.longitude
        self.userLat = lastLocation.coordinate.latitude
        
        
        self.userLocation.latitude = lastLocation.coordinate.latitude
        self.userLocation.longitude = lastLocation.coordinate.longitude

        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: self.userLocation, span: span)
        mapView.setRegion(region, animated: false)
        mapView.showsUserLocation = true
        
        print("\(self.userLong) --- \(self.userLong)")
        
        
    }
    
    func drawRoute() {
        
        let userLocation = CLLocation(latitude: userLat, longitude: userLong)
        let destinationLocation = CLLocation(latitude: Double(location.latitude!)!, longitude: Double(location.longtitude!)!)
        
        let userLocation2D = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let destinationLocation2D = CLLocationCoordinate2D(latitude: Double(location.latitude!)!, longitude: Double(location.longtitude!)!)
        
        var distance = userLocation.distance(from: destinationLocation)
        
        if distance > 1000 {
            distance = distance / 1000
            let value = String(distance)
            let result = String(value.prefix(5))
            self.infoLabel.text = "\(result) km"
        }
        else {
            let value = String(distance)
            let result = String(value.prefix(5))
            self.infoLabel.text = "\(result) m"
        }
        
        let sourcePlaceMark = MKPlacemark(coordinate: userLocation2D, addressDictionary: nil)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation2D, addressDictionary: nil)
        
        
        let destinationAnotation = MKPointAnnotation()
        destinationAnotation.title = location.definition
        if let destinationLocation = destinationPlaceMark.location {
            destinationAnotation.coordinate = destinationLocation.coordinate
        }
        
        self.mapView.addAnnotation(destinationAnotation)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResponse = response else {
                if let error = error {
                    print("Error : \(error.localizedDescription)")
                }
                return
            }
            
            
            let route = directionResponse.routes[0]
            self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: false)
            
            
        }
        self.mapView.delegate = self
        
       
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.lightGray
        renderer.lineWidth = 4.0
        return renderer
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

