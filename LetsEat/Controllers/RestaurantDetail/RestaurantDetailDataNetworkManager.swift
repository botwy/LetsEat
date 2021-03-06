//
//  RestaurantDetailDataManager.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 06.01.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

class RestaurantDetailDataNetworkManager: RestaurantDetailDataManager {
    func fetch(restaurantId: String, completion: @escaping (_ detail: RestaurantItem) -> Void) {
        AppDelegate.networkService.fetch(endpointPath: "restaurants/\(restaurantId)") { (json: JSON.Restaurant) in
            let restaurant = RestaurantItem(restaurant: json)
            completion(restaurant)
        }
    }
}
