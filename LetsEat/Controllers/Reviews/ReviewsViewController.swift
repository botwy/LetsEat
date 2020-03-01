//
//  ReviewsViewController.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 23.02.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit
import CoreData

class ReviewsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let coreDataManager = CoreDataManager()
    var fetchedResultsController: NSFetchedResultsController<Review>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if fetchedResultsController == nil {
            setupFetchResultsController()
        }
    }
}

private extension ReviewsViewController {
    func initialize() {
        setupCollectionView()
    }

    func setupFetchResultsController() {
        guard let viewController = self.parent as? RestaurantDetailViewController,
              let restaurantID = viewController.selectedRestaurant?.restaurantID else {
                return
        }
        let moc = CoreDataStack.shared.persistentContainer.viewContext
        moc.automaticallyMergesChangesFromParent = true
        let request:NSFetchRequest<Review> = Review.fetchRequest()
        let predicate = NSPredicate(format: "restaurantID = %i", Int32(restaurantID))
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = predicate
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
        try? fetchedResultsController?.performFetch()
        collectionView.reloadData()
    }
    
    func setupCollectionView() {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        flow.scrollDirection = .horizontal
        collectionView?.collectionViewLayout = flow
    }
}

extension ReviewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        let review = fetchedResultsController?.object(at: indexPath)
        cell.lblTitle.text = review?.title
        cell.lblDate.text = review?.displayDate
        cell.lblName.text = review?.name
        cell.lblReview.text = review?.customerReview
        cell.ratingView.isEnabled = false
        if let rating = review?.rating {
            cell.ratingView.rating = CGFloat(rating)
        }
    
        return cell
    }
}

extension ReviewsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize {
        if fetchedResultsController?.fetchedObjects?.count == 1 {
           let width = collectionView.frame.size.width - 14
            return CGSize(width: width, height: 200)
        }
        else {
           let width = collectionView.frame.size.width - 21
            return CGSize(width: width, height: 200)
        }
    }
}

extension ReviewsViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.reloadData()
    }
}
