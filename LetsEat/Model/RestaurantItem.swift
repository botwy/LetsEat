//
//  RestaurantAnnotation.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 22.12.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit
import MapKit

class RestaurantItem: NSObject, MKAnnotation {
    
    var name: String?
    var cuisines:[String] = []
    var latitude: Double?
    var longitude:Double?
    var address:String?
    var postalCode:String?
    var state:String?
    var imageURL:String?
    var restaurantID:Int?
    
    convenience init(dict: [String : AnyObject]) {
        self.init()
        if let name  = dict["name"] as? String { self.name = name }
        if let cuisines = dict["cuisines"] as? [String] { self.cuisines = cuisines }
        if let latitude  = dict["lat"] as? Double { self.latitude = latitude }
        if let longitude = dict["lng"] as? Double { self.longitude = longitude }
        if let address = dict["address"] as? String { self.address = address }
        if let postalCode = dict["postalCode"] as? String { self.postalCode = postalCode }
        if let state = dict["state"] as? String { self.state = state }
        if let imageURL = dict["imageURL"] as? String { self.imageURL = imageURL }
        if let id = dict["id"] as? Int { self.restaurantID = id }
    }
    
    var coordinate: CLLocationCoordinate2D {
        guard let latitude = latitude, let longitude = longitude else {
            return CLLocationCoordinate2D()
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var subtitle: String? {
        if cuisines.isEmpty { return "" }
        if cuisines.count == 1 { return cuisines.first }
        
        return cuisines.joined(separator: ", ")
    }
    
    var title: String? {
        return name
    }
}

extension RestaurantItem {
    convenience init(restaurant: JSON.Restaurant) {
        self.init()
        name = restaurant.name
        latitude = restaurant.latitude
        longitude = restaurant.longitude
        address = restaurant.address
        state = restaurant.state
        postalCode = restaurant.postalCode
        imageURL = restaurant.imageURL
        if let cuisines = restaurant.cuisines {
            self.cuisines = cuisines
        }
    }
}
