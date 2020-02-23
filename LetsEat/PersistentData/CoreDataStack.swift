//
//  CoreDataStack.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 23.02.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import CoreData

struct CoreDataStack {
    static let shared = CoreDataStack()
    
    var persistentContainer: NSPersistentContainer {
        return container
    }
    
    private let container: NSPersistentContainer
    
    private init() {
        let container = NSPersistentContainer(name: "LetsEatModel")
        container.loadPersistentStores { (storeDesc, error) in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
        }
        self.container = container
    }
}
