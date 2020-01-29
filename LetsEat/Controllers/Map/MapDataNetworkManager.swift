//
//  MapDataNetworkManager.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 26.12.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation
import MapKit

class MapDataNetworkManager: MapDataManager {
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
        AppDelegate.networkService.fetch(endpointPath: "restaurants") { (restaurants: [JSON.Restaurant]) in
            let items = restaurants.map{ RestaurantItem(restaurant: $0) }
            self.items = items
            completion(items)
        }
    }
}
