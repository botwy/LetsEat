//
//  NetworkRestaurantDataSourceFabric.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 16.02.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

struct NetworkRestaurantDataSourceFabric: RestaurantDataSourceFabric {
    var mapDataSource: MapDataManager {
        return MapDataNetworkManager()
    }
    
    var restaurantDataSource: RestaurantDataManager {
        return RestaurantDataNetworkManager()
    }
    
    var restaurantDetailDataSource: RestaurantDetailDataManager {
        return RestaurantDetailDataNetworkManager()
    }
}
