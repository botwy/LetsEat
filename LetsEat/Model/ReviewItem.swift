//
//  ReviewItem.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 23.02.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

struct ReviewItem: Codable {
    var id:Int?
    var rating:Float?
    var name:String?
    var customerReview:String?
    var date:Date?
    var restaurantID:Int?
    var uuid = UUID().uuidString
    var title: String?
    
    var displayDate:String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter.string(from: self.date!)
    }
}

extension ReviewItem {
    init(data:Review) {
        self.id = Int(data.id)
        self.date = data.date
        self.customerReview = data.customerReview
        self.name = data.name
        self.restaurantID = Int(data.restaurantID)
        self.rating = data.rating
        if let uuid = data.uuid { self.uuid = uuid }
        title = data.title
    }
    
    init(json:JSON.Review, restaurantID: Int) {
        id = json.id
        date = json.date
        customerReview = json.customerReview
        name = json.name
        rating = json.rating
        title = json.title
        self.restaurantID = restaurantID
    }
    
    func makeJson() -> JSON.Review {
        var json = JSON.Review()
        json.id = id
        json.date = date
        json.customerReview = customerReview
        json.name = name
        json.rating = rating
        json.title = title
        
        return json
    }
}
