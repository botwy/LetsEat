//
//  RestaurantDetailViewController.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 29.12.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UITableViewController {

    var manager: RestaurantDetailDataManager?
    
    var selectedRestaurant:RestaurantItem?
    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var stars: UIImageView!
    
//    // Nav Bar
//    @IBOutlet weak var btnHeart: UIBarButtonItem!
//
//    // Cell One
//    @IBOutlet weak var lblName: UILabel!
//    @IBOutlet weak var lblCuisine: UILabel!
//    @IBOutlet weak var lblHeaderAddress: UILabel!
//
//    // Cell Two
//    @IBOutlet weak var lblTableDetails: UILabel!
//
//    // Cell Three
//    @IBOutlet weak var lblOverallRating: UILabel!
//
//    // Cell Eight
//    @IBOutlet weak var lblAddress: UILabel!
//    @IBOutlet weak var imgMap: UIImageView!
    
    @IBAction func onTimeTapped(sender: UIButton) {
        showNotification(sender: sender.titleLabel?.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameLabel?.text = selectedRestaurant?.name
        initialize()
        dump(selectedRestaurant as Any)
    }
    
    func initialize() {
       setupNotificationDefaults()
        manager?.fetch { (detail) in
            switch(detail.starNumber) {
            case 0: break;
            case 1:
                self.stars.image = UIImage(named: "1star")
                break
            case 2:
                self.stars.image = UIImage(named: "2star")
                break
            case 3:
                self.stars.image = UIImage(named: "3star")
                break
            case 4:
                self.stars.image = UIImage(named: "4star")
                break
            case 5:
                self.stars.image = UIImage(named: "5star")
                break
            default:
                break
            }
        }
    }
    
    func setupNotificationDefaults() {
       UNUserNotificationCenter.current().delegate = self
    }
    
    func showNotification(sender:String?) {
       let content = UNMutableNotificationContent()
       content.title = "selected restaurant name"
       if let time = sender { content.body = "Table for 7, tonight at \(time) " }
       content.subtitle = "Restaurant Reservation"
       content.badge = 1
       content.sound = UNNotificationSound.default
        content.categoryIdentifier = Identifier.reservationCategory.rawValue
        do {
           let url = Bundle.main.url(forResource: "sample-restaurant-img@3x", withExtension: "png")
           if let imgURL = url {
                  let attachment = try UNNotificationAttachment(identifier: "letsEatReservation", url: imgURL, options: nil)
                  content.attachments = [attachment]
                  let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                  let identifier = "letsEatReservation"
                  let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                  UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                         // handle error
                  })
           }
        }
        catch {
           print("there was an error with the notification")
        }
    }
}

extension RestaurantDetailViewController: UNUserNotificationCenterDelegate {
   func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
          completionHandler([.alert, .sound])
   }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
       if let identifier = Option(rawValue: response.actionIdentifier) {
              switch identifier {
              case .one :
                     print("User selected yes")
              case .two:
                     print("User selected no")
              }
       }
       completionHandler()
    }
}
