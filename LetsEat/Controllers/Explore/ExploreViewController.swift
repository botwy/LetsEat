//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by Craig Clayton on 6/30/17.
//  Copyright © 2017 Cocoa Academy. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UICollectionViewDelegate {
    
    var restaurantDataSourceFabric: RestaurantDataSourceFabric?
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedCity:String?
    var headerView: ExploreHeaderView!
    
    var manager = ExploreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.fetch()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Segue.restaurantList.rawValue {
            guard selectedCity != nil else {
                showAlert()
                return false
            }
            return true
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        switch segue.identifier! {
            case Segue.locationList.rawValue:
                showLocationList(segue: segue)
            case Segue.restaurantList.rawValue:
                showRestaurantListing(segue: segue)
            default:
            debugPrint("Segue not added")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        self.headerView = headerView as? ExploreHeaderView
        return headerView
    }
    
    private func showLocationList(segue:UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController,
            let viewController = navController.topViewController as? LocationViewController else {
                return
        }
        guard let city = selectedCity else { return }
        viewController.selectedCity = city
    }
    
    private func showRestaurantListing(segue:UIStoryboardSegue) {
       if let viewController = segue.destination as? RestaurantViewController,
          let city = selectedCity,
          let index = collectionView.indexPathsForSelectedItems?.first,
          let type = manager.explore(at: index).name {
              viewController.selectedType = type
              viewController.selectedCity = city
        viewController.manager = restaurantDataSourceFabric?.restaurantDataSource
        viewController.restaurantDataSourceFabric = restaurantDataSourceFabric
       }
    }
    
    private func showAlert() {
                    let alertController = UIAlertController(title: "Location Needed", message:"Please select a location.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    present(alertController, animated: true, completion: nil)
    }

    // Add Unwind here
    @IBAction func unwindLocationCancel(sender: UIStoryboardSegue) {}
    
    // Add Unwind here
    @IBAction func unwindLocationDo(sender: UIStoryboardSegue) {
        if let viewController = sender.source as? LocationViewController {
            selectedCity = viewController.selectedCity
            if let location = selectedCity {
                headerView.lblLocation.text = location
            }
        }
    }
}

extension ExploreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCell
        let exploreItem = manager.explore(at: indexPath)
        
        cell.lblName.text = exploreItem.name
        if let imgName = exploreItem.image {
            cell.imgExplore.image = UIImage(named: imgName)
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.numberOfItems
    }
}





































