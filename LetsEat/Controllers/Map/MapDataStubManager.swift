//
//  MapDataManager.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 22.12.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation
import MapKit

class MapDataStubManager: MapDataManager {
    private var items: [RestaurantItem] = []
    
    var annotations: [RestaurantItem] {
        return items
    }
    
    func currentRegion(latDelta: CLLocationDegrees, longDelta: CLLocationDegrees) -> MKCoordinateRegion {
        guard let item = items.first else { return MKCoordinateRegion() }
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        return MKCoordinateRegion(center: item.coordinate, span: span)
    }
    
    func fetch(completion: @escaping (_ annotations: [RestaurantItem]) -> Void) {
        if items.count > 0 {
            items.removeAll()
        }
        let dictList = loadData()
        items = dictList.map { RestaurantItem(dict: $0) }
        completion(items)
    }
    
    private func loadData() -> [[String:AnyObject]] {
        guard let path = Bundle.main.path(forResource: "MapLocations", ofType: "plist"),
            let dictList = NSArray(contentsOfFile: path) else {
                return [[:]]
        }
        
        return dictList as! [[String:AnyObject]]
    }
}
