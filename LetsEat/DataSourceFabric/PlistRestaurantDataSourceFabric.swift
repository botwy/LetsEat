//
//  NetworkRestaurantDataSourceFabric.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 16.02.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

struct PlistRestaurantDataSourceFabric: RestaurantDataSourceFabric {
    var mapDataSource: MapDataManager {
        return MapDataStubManager()
    }
    
    var restaurantDataSource: RestaurantDataManager {
        return RestaurantDataStubManager()
    }
    
    var restaurantDetailDataSource: RestaurantDetailDataManager {
        return RestaurantDetailDataNetworkManager()
    }
}
