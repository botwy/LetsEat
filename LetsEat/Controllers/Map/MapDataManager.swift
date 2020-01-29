//
//  DataSource.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 08.01.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation
import MapKit

protocol MapDataManager {
    func fetch(completion: @escaping ([RestaurantItem]) -> Void)
    func currentRegion(latDelta: CLLocationDegrees, longDelta: CLLocationDegrees) -> MKCoordinateRegion
    var annotations: [RestaurantItem] { get }
}
