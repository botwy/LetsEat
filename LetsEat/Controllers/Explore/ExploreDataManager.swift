//
//  ExploreDataManager.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 15.12.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

struct ExploreDataManager {
    
    private var items: [ExploreItem] = []
    
    private func loadData() -> [[String : AnyObject]] {
        guard let plistPath = Bundle.main.path(forResource: "ExploreData", ofType: "plist"),
            let items = NSArray(contentsOfFile: plistPath) else {
                return [[:]]
        }
        
        return items as! [[String : AnyObject]]
    }
    
    mutating func fetch() {
        for dataItem in loadData() {
            items.append(ExploreItem(dict: dataItem))
        }
    }
    
    var numberOfItems: Int {
        return items.count
    }
    
    func explore(at indexPath: IndexPath) -> ExploreItem {
        return items[indexPath.row]
    }
}
