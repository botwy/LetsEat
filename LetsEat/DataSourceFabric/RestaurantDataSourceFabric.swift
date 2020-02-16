//
//  RestaurantDataSourceFabric.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 16.02.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

protocol RestaurantDataSourceFabric {
    var mapDataSource: MapDataManager { get }
    var restaurantDataSource: RestaurantDataManager { get }
    var restaurantDetailDataSource: RestaurantDetailDataManager { get }
}
