//
//  Location.swift
//  LocationList
//
//  Created by Ekin Barış Demir on 25.06.2021.
//

import Foundation
import UIKit


class Location: NSObject, NSCoding {
    
    var longtitude: String?
    var latitude: String?
    var saveDate: String?
    var locationAdress: String?
    var type: String?
    var definition: String?
    
    init(longtitude: String, latitude: String, saveDate: String, locationAdress: String, type: String, definition: String) {
        
        
        self.longtitude = longtitude
        self.latitude = latitude
        self.saveDate = saveDate
        self.locationAdress = locationAdress
        self.type = type
        self.definition = definition
        
    }
    
    override init() {
        super.init()
    }
    
    
    required convenience init?(coder aCoder: NSCoder) {

        let longtitude = aCoder.decodeObject(forKey: "longtitude") as? String ?? ""
        let latitude = aCoder.decodeObject(forKey: "latitude") as? String ?? ""
        let saveDate = aCoder.decodeObject(forKey: "saveDate") as? String ?? ""
        let locationAdress = aCoder.decodeObject(forKey: "locationAdress") as? String ?? ""
        let type = aCoder.decodeObject(forKey: "type") as? String ?? ""
        let definition = aCoder.decodeObject(forKey: "definition") as? String ?? ""
        
        self.init(longtitude: longtitude, latitude: latitude, saveDate: saveDate, locationAdress: locationAdress, type: type, definition: definition)
    }
    
    func encode(with aCoder: NSCoder) {
    
        aCoder.encode(longtitude, forKey: "longtitude")
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(saveDate, forKey: "saveDate")
        aCoder.encode(locationAdress, forKey: "locationAdress")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(definition, forKey: "definition")
        
    }
    
}
