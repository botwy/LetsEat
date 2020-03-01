//
//  RestaurantDetailDataManager.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 06.01.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

class ReviewDataNetworkManager {
    func createReview(review: ReviewItem, restaurantId: String, completion: @escaping (_ detail: RestaurantItem) -> Void) {
        AppDelegate.networkService.fetchPost(endpointPath: "restaurants/\(restaurantId)/addReview", body: review.makeJson()) { (json: JSON.Restaurant) in
            let restaurant = RestaurantItem(restaurant: json)
            completion(restaurant)
        }
    }
}
