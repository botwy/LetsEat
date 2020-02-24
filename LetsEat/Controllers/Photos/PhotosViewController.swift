//
//  PhotosViewController.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 23.02.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let manager = CoreDataManager()
    var data: [RestaurantPhotoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupDefaults()
    }
}

private extension PhotosViewController {
    func initialize() {
        setupCollectionView()
    }

    func setupDefaults() {
        checkPhotos()
    }

    func setupCollectionView() {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        flow.scrollDirection = .horizontal
        collectionView?.collectionViewLayout = flow
    }

    func checkPhotos() {
        let viewController = self.parent as? RestaurantDetailViewController
        if let id = viewController?.selectedRestaurant?.restaurantID {
            if data.count > 0 { data.removeAll() }
            data = manager.fetchPhotos(by: id)
            if data.count > 0 {
                collectionView.backgroundView = nil
            }
            else {
                let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
                view.set(title: "Photos")
                view.set(desc: "There are currently no photos")
                collectionView.backgroundView = view
            }
            collectionView.reloadData()
        }
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        let restaurantPhotoItem = data[indexPath.row]
        cell.imageView.image = restaurantPhotoItem.photo
        
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize {
            return CGSize(width: 200, height: 200)
    }
}
