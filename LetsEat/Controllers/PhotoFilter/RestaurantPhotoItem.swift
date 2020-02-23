//
//  RestaurantPhotoItem.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 23.02.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit

struct RestaurantPhotoItem {
    var photo:UIImage?
    var date:Date?
    var restaurantID:Int?
    var uuid = UUID().uuidString
    var photoData:Data {
        guard let image = photo, let data = image.pngData() else {
            return Data()
        }
        return data
    }
}

extension RestaurantPhotoItem {
    init(data:RestaurantPhoto) {
        self.date = data.date
        self.restaurantID = Int(data.restaurantID)
        if let photo = data.photo {
            self.photo = UIImage(data:photo, scale:1.0)
        }
        
        if let uuid = data.uuid {
            self.uuid = uuid
        }
    }
}
