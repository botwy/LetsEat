//
//  NotificationViewController.swift
//  LetsEatContentExtension
//
//  Created by Гончаров Денис Васильевич on 29.12.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }

}
