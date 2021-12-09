//
//  ViewController.swift
//  Project21
//
//  Created by Jamie Brannan on 09/12/2021.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
  }
  
  @objc func registerLocal() {
    let center = UNUserNotificationCenter.current()
    
    center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
      if granted {
        print("Yay!")
      } else {
        print("D'oh")
      }
    }
  }
  
  @objc func scheduleLocal() {
    let center = UNUserNotificationCenter.current()
    center.removeAllPendingNotificationRequests()
    
    let content = UNMutableNotificationContent()
    content.title = "Late wake up call"
    content.body = "The early bird catches the worm, but the second mouse gets the cheese."
    content.categoryIdentifier = "alarm"
    content.userInfo = ["customData": "fizzbuzz"]
    content.sound = UNNotificationSound.default
    
    var dateComponents = DateComponents()
    dateComponents.hour = 10
    dateComponents.minute = 30
//    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) /// Fake trigger just for practice time
    
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    center.add(request)
  }
  
}

