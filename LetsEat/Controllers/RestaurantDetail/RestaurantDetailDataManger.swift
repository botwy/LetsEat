//
//  RestaurantDetailDataManger.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 08.01.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

protocol RestaurantDetailDataManager {
    func fetch(completion: @escaping (RestaurantDetail) -> Void)
}
