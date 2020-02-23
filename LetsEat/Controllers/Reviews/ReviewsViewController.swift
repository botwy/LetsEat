//
//  ReviewsViewController.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 23.02.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedRestaurantID:Int?
    let manager = CoreDataManager()
    var data: [ReviewItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupDefaults()
    }
}

private extension ReviewsViewController {
    func initialize() {
        setupCollectionView()
    }

    func setupDefaults() {
        checkReviews()
    }

    func setupCollectionView() {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        flow.scrollDirection = .horizontal
        collectionView?.collectionViewLayout = flow
    }

    func checkReviews() {
        let viewController = self.parent as? RestaurantDetailViewController
        if let id = viewController?.selectedRestaurant?.restaurantID {
            if data.count > 0 { data.removeAll() }
            data = manager.fetchReviews(by: id)
            if data.count > 0 {
                collectionView.backgroundView = nil
            }
            else {
//                let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
//                view.set(title: "Reviews")
//                view.set(desc: "There are currently no reviews")
//                collectionView.backgroundView = view
            }
            collectionView.reloadData()
        }
    }
}

extension ReviewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        let review = data[indexPath.row]
        cell.lblTitle.text = review.title
        cell.lblDate.text = review.displayDate
        cell.lblName.text = review.name
        cell.lblReview.text = review.customerReview
        if let rating = review.rating {
            cell.ratingView.rating = CGFloat(rating)
        }
        
        return cell
    }
}

extension ReviewsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize {
        if data.count == 1 {
           let width = collectionView.frame.size.width - 14
            return CGSize(width: width, height: 200)
        }
        else {
           let width = collectionView.frame.size.width - 21
            return CGSize(width: width, height: 200)
        }
    }
}
