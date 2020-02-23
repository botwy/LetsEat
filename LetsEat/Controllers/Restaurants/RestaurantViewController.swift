//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by Craig Clayton on 6/30/17.
//  Copyright © 2017 Cocoa Academy. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController, UICollectionViewDelegate {
    
    var restaurantDataSourceFabric: RestaurantDataSourceFabric?
    
    @IBOutlet weak var collectionView: UICollectionView!
    var manager: RestaurantDataManager?
    var selectedRestaurant:RestaurantItem?
    var selectedCity:String?
    var selectedType:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = selectedCity, let cuisineType = selectedType else { return }
        manager?.fetch(byLocation: city, withFilter: cuisineType, completion: { (restaurants) in
            self.collectionView.reloadData()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTitle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        switch segue.identifier! {
        case Segue.showDetail.rawValue:
            showRestaurantDetail(segue: segue)
        default:
            debugPrint("Segue not added")
        }
    }
    
    private func showRestaurantDetail(segue: UIStoryboardSegue) {
        guard let controller = segue.destination as? RestaurantDetailViewController,
              let indexPath = collectionView.indexPathsForSelectedItems?.first else {
            return
        }
        
        let restaurant = manager?.getItem(at: indexPath)
        controller.selectedRestaurant = restaurant
        controller.manager = restaurantDataSourceFabric?.restaurantDetailDataSource
    }
    
    private func setupTitle() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        if let city = selectedCity {
            title = "\(city.uppercased())"
        }
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension RestaurantViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantCell
           let restaurant = manager?.getItem(at: indexPath)
           cell.nameLabel.text = restaurant?.name
           if let cuisines = restaurant?.cuisines, cuisines.count > 0 {
               cell.cuisineLabel.text = restaurant?.cuisines.joined(separator: ", ")
           }
           if let imageURL = restaurant?.imageURL,
               let url = URL(string: imageURL) {
               DispatchQueue.global().async {
                   guard let data = try? Data(contentsOf: url) else { return }
                   DispatchQueue.main.async {
                       cell.photo.image = UIImage(data: data)
                   }
               }
           }
           
           return cell
       }
       
       func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return manager?.numberOfItems ?? 0
       }
}
