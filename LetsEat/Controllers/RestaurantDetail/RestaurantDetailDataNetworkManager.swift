//
//  RestaurantDetailDataManager.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 06.01.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

class RestaurantDetailDataNetworkManager: RestaurantDetailDataManager {
    func fetch(completion: @escaping (_ detail: RestaurantDetail) -> Void) {
        AppDelegate.networkService.fetch(endpointPath: "restaurants/115903") { (restaurant: JSON.RestaurantDetail) in
            let detail = RestaurantDetail(detail: restaurant)
            completion(detail)
        }
    }
}
