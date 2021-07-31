//
//  SaveLocationViewController.swift
//  LocationList
//
//  Created by Ekin Barış Demir on 25.06.2021.
//

import UIKit
import MapKit
import CoreLocation

class SaveLocationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addButton: CustomButton!
    var locationManager:CLLocationManager = CLLocationManager()
    var location: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var longtitude = String()
    var latitude = String()
    var userAddress = String()
    var date = String()
    var newLoc = Location()
    var allLoc = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allLoc = StoreManager.shared.getLocation()
        addButton.layer.cornerRadius = 20
        setupLocationManager()
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true

    }
    
    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        showLocs()

        
    }
    
    func showLocs() {
        self.mapView.delegate = self

        if allLoc.count != 0 {
            let x = allLoc.count
            print(x)
                for i in 0...x {
                    
                    let locs = CLLocationCoordinate2D(latitude: Double(allLoc[i].latitude!)!, longitude: Double(allLoc[i].latitude!)!)
                    let placeMark = MKPlacemark(coordinate: locs, addressDictionary: nil)
                    print("placemark bitti")
                    let anotation = MKPointAnnotation()
                    anotation.title = allLoc[i].definition
                    if let loc = placeMark.location {
                        anotation.coordinate = loc.coordinate
                    }
                    
                    self.mapView.addAnnotation(anotation)
                    return
                }
        }
        else {
            return
        }
        
       
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let lastLocation: CLLocation = locations[locations.count-1]
        self.longtitude = String(lastLocation.coordinate.longitude)
        self.latitude = String(lastLocation.coordinate.latitude)
        
        self.location.latitude = lastLocation.coordinate.latitude
        self.location.longitude = lastLocation.coordinate.longitude
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: self.location, span: span)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
        print("\(self.longtitude) --- \(self.latitude)")
        getAddressFromLatLon(pdblLatitude: self.latitude, withLongitude: self.longtitude)

    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)") ?? 0.0
        let lon: Double = Double("\(pdblLongitude)") ?? 0.0
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler: {(placemarks, error) in
            
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]
            
            if pm.count > 0 {
                let pm = placemarks![0]
                var addressString : String = ""
                
                if pm.thoroughfare != nil { // CADD
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil { //ŞEHİR
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {  //ÜLKE
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil { //POSTA KODU
                    addressString = addressString + pm.postalCode! + " "
                }
                
                print("***********\(addressString)")
                self.userAddress = addressString
                
                let date = Date()
                let df = DateFormatter()
                df.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateString: String = df.string(from: date)
                print(dateString)
                self.date = dateString
                
                
                let newLocation = Location(longtitude: self.longtitude, latitude: self.latitude, saveDate: self.date, locationAdress: self.userAddress, type: "", definition: "")
                self.newLoc = newLocation
        
            }
        })
    }
    
    @IBAction func addButton(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = mainStoryboard.instantiateViewController(withIdentifier: "SaveDetailsViewController") as? SaveDetailsViewController {
            vc.userLocation = self.newLoc
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


