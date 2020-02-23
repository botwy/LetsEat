//
//  FilterItem.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 22.02.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit

class FilterItem: NSObject {
    
   let filter:String
   let name:String
    
    init(dict:[String:AnyObject]) {
        name  = dict["name"] as! String
        filter = dict["filter"] as! String
    }
}
