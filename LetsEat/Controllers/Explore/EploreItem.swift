//
//  EploreItem.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 15.12.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

enum ExploreDictionaryFields: String {
    case name, image
}

struct ExploreItem {
    var name: String?
    var image: String?
}

extension ExploreItem {
    init(dict: [String: AnyObject]) {
        name = dict[ExploreDictionaryFields.name.rawValue] as? String
        image = dict[ExploreDictionaryFields.image.rawValue] as? String
    }
}
