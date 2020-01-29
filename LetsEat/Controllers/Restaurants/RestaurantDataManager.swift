//
//  RestaurantDataManager.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 24.01.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

protocol RestaurantDataManager {
    func fetch(completion: @escaping ([RestaurantItem]) -> Void)
    var numberOfItems: Int { get }
    func getItem(at indexPath: IndexPath) -> RestaurantItem
}
