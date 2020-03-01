//
//  Reviews+Extension.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 01.03.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import CoreData

extension Review {
    convenience init (context: NSManagedObjectContext, reviewItem item: ReviewItem) {
        self.init(context: context)
        if let id = item.id {
            self.id = Int32(id)
             print("review id \(id)")
        }
        if let rating = item.rating {
            self.rating = rating
        }
        name = item.name
        date = Date()
        customerReview = item.customerReview
        uuid = item.uuid
        title = item.title
        
        if let restaurantID = item.restaurantID {
            self.restaurantID = Int32(restaurantID)
        }
    }
    
    var displayDate:String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter.string(from: self.date!)
    }
}
