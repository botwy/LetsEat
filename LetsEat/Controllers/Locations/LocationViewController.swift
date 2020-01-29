//
//  LocationViewController.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 17.12.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var selectedCity:String?
    
    let manager = LocationDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.accessoryType = .checkmark
        selectedCity = manager.locationItem(at:indexPath)
        tableView.reloadData()
        
//        if cell.accessoryType == .checkmark {
//            cell.accessoryType = .none
//        } else {
//            cell.accessoryType = .checkmark
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        cell.textLabel?.text = manager.locationItem(at: indexPath)
        set(selected: cell, at: indexPath)
        
        return cell
    }
    
    func  set(selected cell: UITableViewCell, at indexPath: IndexPath) {
        if let city = selectedCity {
            let data = manager.findLocation(by: city)
            if data.isFound {
               if indexPath.row == data.position {
                      cell.accessoryType = .checkmark
               }
               else { cell.accessoryType = .none }
            }
        } else {
            cell.accessoryType = .none
        }
    }
}
