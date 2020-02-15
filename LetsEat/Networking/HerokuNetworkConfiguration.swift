//
//  HerokuNetworkConfiguration.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 15.02.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

struct HerokuNetworkConfiguration: NetworkConfiguration {
    var baseUrlPath: String {
        return "https://lets-eat-botwy.herokuapp.com/letseat"
    }
}
