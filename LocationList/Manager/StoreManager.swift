//
//  StoreManager.swift
//  LocationList
//
//  Created by Ekin Barış Demir on 25.06.2021.
//

import Foundation
class StoreManager {
    
    static let shared = StoreManager()
    
    
    private static func storeLocation(data : [Location]) -> NSData {
        
        return NSKeyedArchiver.archivedData(withRootObject: data as NSArray) as NSData
    }
    
    func loadLocation() -> [Location]? {
        
        if let unarchivedObject = UserDefaults.standard.object(forKey: "location") as? Data {
            
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [Location]
        }
        
        return nil
    }
    
    func getLocation() -> [Location] {
        var location: [Location] = [Location]()
        if StoreManager.shared.loadLocation() == nil {
            StoreManager.shared.saveLocation(data: location)
        }
        else {
            location = StoreManager.shared.loadLocation() ?? []
        }
        return location
    }

    
    func saveLocation(data : [Location]?) {
        
        let archivedObject = StoreManager.storeLocation(data: data!)
        UserDefaults.standard.set(archivedObject, forKey: "location")
        
        UserDefaults.standard.synchronize()
    }
    
    
    

}
