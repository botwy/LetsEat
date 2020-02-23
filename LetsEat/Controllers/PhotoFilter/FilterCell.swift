//
//  FilterCell.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 22.02.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell {
    @IBOutlet var lblName:UILabel!
    @IBOutlet var imgThumb: UIImageView!
    
    private var data:FilterItem?
    weak var filteringDelegate: ImageFilteringDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGestureRecognizer()
    }
}

extension FilterCell: ImageFiltering {
    func set(image:UIImage, item:FilterItem) {
        data = item
        if item.filter != "None" {
            let filteredImg = apply(filter: item.filter, originalImage: image)
            imgThumb.image = filteredImg
        } else {
            imgThumb.image = image
        }
        lblName.text = item.name
        
        roundedCorners()
    }
    
    func roundedCorners() {
        imgThumb.layer.cornerRadius = 9
        imgThumb.layer.masksToBounds = true
    }
}

private extension FilterCell {
    func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action:#selector(thumbTapped))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    @objc func thumbTapped() {
        if let data = self.data {
            filterSelected(item: data)
        }
    }
    
    func filterSelected(item:FilterItem) {
        filteringDelegate?.filterSelected(item: item)
    }
}
