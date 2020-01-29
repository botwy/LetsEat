//
//  JSON.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 26.12.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

struct JSON {
    
}

extension JSON {
    struct Restaurant: Codable {
        var id: Int
        var name: String
        var latitude: Double
        var longitude:Double
        var address:String?
        var postalCode:String?
        var state:String?
        var imageURL:String?
        var cuisines:[String]?
    }
    
    struct RestaurantDetail: Codable {
        var id: Int
        var name: String
        var address:String?
        var starNumber: Int?
    }
}
