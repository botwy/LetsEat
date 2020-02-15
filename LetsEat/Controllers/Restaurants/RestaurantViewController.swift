//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by Craig Clayton on 6/30/17.
//  Copyright © 2017 Cocoa Academy. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var manager: RestaurantDataManager? = RestaurantDataNetworkManager()
    var selectedRestaurant:RestaurantItem?
    var selectedCity:String?
    var selectedType:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager?.fetch(completion: { (restaurants) in
            self.collectionView.reloadData()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      print("selected city \(selectedCity as Any)")
      print("selected type \(selectedType as Any)")
    }
    
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
