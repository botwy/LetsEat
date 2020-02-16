//
//  RestaurantDataNetworkManager.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 24.01.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

class RestaurantDataStubManager: RestaurantDataManager {
    
    private var items: [RestaurantItem] = []
    private var location: String?
    private var cuisineFilter: String?
    
    var numberOfItems: Int {
        items.count
    }
    
    func getItem(at indexPath: IndexPath) -> RestaurantItem {
        return items[indexPath.row]
    }
    
    func fetch(byLocation location: String, withFilter: String = "All", completion: @escaping ([RestaurantItem]) -> Void) {
        self.location = location
        self.cuisineFilter = withFilter
        
        if items.count > 0 {
            items.removeAll()
        }
        let dictList = loadData()
        items = dictList.map { RestaurantItem(dict: $0) }
        filterItems()
        completion(items)
    }
    
    private func loadData() -> [[String:AnyObject]] {
        guard let path = Bundle.main.path(forResource: "Restaurants", ofType: "plist"),
            let dictList = NSArray(contentsOfFile: path) else {
                return [[:]]
        }
        
        return dictList as! [[String:AnyObject]]
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
