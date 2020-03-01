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
    
    struct Cuisine: Codable {
        var id: Int
        var code: String
        var value: String
    }
    
    struct Restaurant: Codable {
        var id: Int
        var name: String
        var latitude: Double
        var longitude:Double
        var address:String?
        var postalCode:String?
        var state:String?
        var imageURL:String?
        var reviews: [Review]
        var cuisines:[Cuisine]?
    }
    
    struct Review: Codable {
        var id:Int?
        var rating:Float?
        var name:String?
        var customerReview:String?
        var date:Date?
        var title: String?
    }
    
    struct RestaurantDetail: Codable {
        var id: Int
        var name: String
        var address:String?
        var starNumber: Int?
    }
}
