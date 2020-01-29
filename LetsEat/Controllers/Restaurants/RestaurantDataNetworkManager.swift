//
//  RestaurantDataNetworkManager.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 24.01.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

class RestaurantDataNetworkManager: RestaurantDataManager {
    
    private var items: [RestaurantItem] = []
    
    func fetch(completion: @escaping ([RestaurantItem]) -> Void) {
        AppDelegate.networkService.fetch(endpointPath: "restaurants") { (restaurants: [JSON.Restaurant]) in
            let items = restaurants.map{ RestaurantItem(restaurant: $0) }
            self.items = items
            completion(items)
        }
    }
    
    var numberOfItems: Int {
        items.count
    }
    
    func getItem(at indexPath: IndexPath) -> RestaurantItem {
        return items[indexPath.row]
    }
}
