//
//  LocationDataManager.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 18.12.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

enum LocationDictionaryFields: String {
    case city, state
}

struct LocationDataManager {
    
    private var items: [String] = []
    
    var numberOfItems: Int {
        return items.count
    }
    
    init() {
        fetch()
    }
    
    func locationItem(at indexPath: IndexPath) -> String {
        return items[indexPath.row]
    }
    
    func loadData() -> [[String : AnyObject]] {
        guard let path = Bundle.main.path(forResource: "LocationData", ofType: "plist"),
            let data = NSArray(contentsOfFile: path) else {
                return [[:]]
        }
        
        return data as! [[String : AnyObject]]
    }
    
    mutating func fetch() {
        let dictionaryList = loadData()
        for item in dictionaryList {
            let state = item[LocationDictionaryFields.state.rawValue] as? String
            let city = item[LocationDictionaryFields.city.rawValue] as? String
            let locationValue = "\(city ?? ""), \(state ?? "")"
            items.append(locationValue)
        }
    }
    
    func findLocation(by name:String) -> (isFound:Bool, position:Int) {
        guard let index = items.firstIndex(of: name) else
                    { return (isFound:false, position:0) }
                    return (isFound:true, position:index)
    }
}
