//
//  HerokuNetworkConfiguration.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 15.02.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

struct LocalNetworkConfiguration: NetworkConfiguration {
    var baseUrlPath: String {
        return "http://localhost:8080/letseat"
    }
}
