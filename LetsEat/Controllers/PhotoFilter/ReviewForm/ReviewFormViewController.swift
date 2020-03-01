//
//  ReviewFormController.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 22.02.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit

class ReviewFormViewController: UITableViewController {

    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tvReview: UITextView!
    
    var selectedRestaurantID:Int?
    let dataManager = ReviewDataNetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension ReviewFormViewController {
    @IBAction func onSaveTapped(_ sender: Any) {
        var item = ReviewItem()
        item.title = tfTitle.text
        item.name = tfName.text
        item.customerReview = tvReview.text
        item.restaurantID = selectedRestaurantID
        item.rating = Float(ratingView.rating)
        guard let selectedRestaurantID = selectedRestaurantID else { return }
        
        let restaurantId = String(describing: selectedRestaurantID)
        dataManager.createReview(review: item, restaurantId: restaurantId) { (restaurant: RestaurantItem) in
            let coreDataManager = CoreDataManager()
            coreDataManager.importReviews(restaurant.reviews)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
