//
//  RestaurantDetail.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 06.01.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

struct RestaurantDetail {
    var id: Int
    var name: String
    var address:String?
    var starNumber: Int
}

extension RestaurantDetail {
    init(detail: JSON.RestaurantDetail) {
        id = detail.id
        name = detail.name
        address = detail.address
        starNumber = detail.starNumber ?? 0
    }
}
