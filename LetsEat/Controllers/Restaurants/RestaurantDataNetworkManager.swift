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
    private var location: String?
    private var cuisineFilter: String?
    private var fetchCompletion: (([RestaurantItem]) -> Void)?
    
    var numberOfItems: Int {
        items.count
    }
    
    func getItem(at indexPath: IndexPath) -> RestaurantItem {
        return items[indexPath.row]
    }
    
    func fetch(byLocation location: String, withFilter: String = "All", completion: @escaping ([RestaurantItem]) -> Void) {
        self.location = location
        self.cuisineFilter = withFilter
        fetchCompletion = completion
        
        AppDelegate.networkService.fetch(endpointPath: "restaurants") { (json: [JSON.Restaurant]) in
            self.items = json.map{ RestaurantItem(restaurant: $0) }
            self.filterItems()
            self.fetchCompletion?(self.items)
        }
    }
    
    private func filterItems() {
        guard let cuisineFilter = cuisineFilter else {
            return
        }
        if cuisineFilter != "All" {
            items = items.filter{ $0.cuisines.contains(cuisineFilter) }
        }
    }
}
