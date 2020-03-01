//
//  CoreDataManager.swift
//  LetsEat
//
//  Created by Craig Clayton on 7/28/17.
//  Copyright © 2017 Cocoa Academy. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    private var selectedID:Int?
    
    private var container: NSPersistentContainer {
        return CoreDataStack.shared.persistentContainer
    }
    
    private func save() {
        do {
            if container.viewContext.hasChanges {
                try container.viewContext.save()
                print("saved")
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func addReview(_ item:ReviewItem) {
        let review = Review(context: container.viewContext)
        if let id = item.id {
            review.id = Int32(id)
        }
        if let rating = item.rating { review.rating = rating }
        review.name = item.name
        review.date = Date()
        review.customerReview = item.customerReview
        review.uuid = item.uuid
        review.title = item.title
        
        if let id = item.restaurantID {
            review.restaurantID = Int32(id)
            print("restaurant id \(id)")
            save()
        }
    }
    
    func importReviews(_ items:[ReviewItem]) {
        container.performBackgroundTask { (moc) in
            let request:NSFetchRequest<Review> = Review.fetchRequest()
            do {
                let reviews = try moc.fetch(request)
                let oldIds = Set<Int>(reviews.compactMap{ Int($0.id) })
                let newIds = Set<Int>(items.compactMap{ $0.id })
                let idsForImport = newIds.subtracting(oldIds)
                let filteredItems = items.filter{ idsForImport.contains($0.id!) }
                filteredItems.forEach {
                    _ = Review(context: moc, reviewItem: $0)
                }
                if moc.hasChanges {
                    try moc.save()
                    print("background saved")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func addPhoto(_ item:RestaurantPhotoItem) {
        let photo = RestaurantPhoto(context: container.viewContext)
        photo.date = Date()
        photo.photo = item.photoData
        photo.uuid = item.uuid
        
        if let id = item.restaurantID {
            photo.restaurantID = Int32(id)
            print("restaurant id \(id)")
            save()
         }
     }
    
    func fetchReviews(by identifier:Int) -> [ReviewItem] {
        let moc = container.viewContext
        let request:NSFetchRequest<Review> = Review.fetchRequest()
        let predicate = NSPredicate(format: "restaurantID = %i", Int32(identifier))
        
        var items:[ReviewItem] = []
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = predicate
        
        do {
            for data in try moc.fetch(request) {
                items.append(ReviewItem(data: data))
            }
            
            return items
            
        } catch {
            fatalError("Failed to fetch reviews: \(error)")
        }
    }
    
    func fetchPhotos(by identifier:Int) -> [RestaurantPhotoItem] {
        let moc = container.viewContext
        let request:NSFetchRequest<RestaurantPhoto> = RestaurantPhoto.fetchRequest()
        let predicate = NSPredicate(format: "restaurantID = %i", Int32(identifier))
        
        var items:[RestaurantPhotoItem] = []
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = predicate
        
        do {
            for data in try moc.fetch(request) {
                items.append(RestaurantPhotoItem(data: data))
            }
            
            return items
            
        } catch {
            fatalError("Failed to fetch reviews: \(error)")
        }
    }
    
    func fetchRestaurantRating(by identifier:Int) -> Float {
        
        let reviews = fetchReviews(by: identifier).map({ $0 })
        let sum = reviews.reduce(0, {$0 + ($1.rating ?? 0)})
        
        return sum / Float(reviews.count)
    }
}
