//
//  ViewController.swift
//  Project21
//
//  Created by Jamie Brannan on 09/12/2021.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

  // MARK: Props

  enum actionMessage: String {
    case automaticId = "Default identifier"
    case showId = "Show more information…"
  }

  // MARK: Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
  }

  // MARK: - Navigation Buttons

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
    registerCategories()
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
    // MARK: - Mega important: must lock simulator after hitting schedule in order to trigger notification!
    
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    center.add(request)
  }

  // MARK: - Notifications

  // MARK: Actions
  func registerCategories() {
    let center = UNUserNotificationCenter.current()
    center.delegate = self
    
    let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
    
    let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])
    
    center.setNotificationCategories([category])
  }

  // MARK: - Alerts

  func presentActionIdAlert(for caseMessage: String) {
    let alert = UIAlertController(title: "My Alert", message: caseMessage, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }

  // MARK: Callbacks

  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    // pull out the buried userInfo dictionary
    let userInfo = response.notification.request.content.userInfo
    
    if let customData = userInfo["customData"] as? String {
      print("Custom data received: \(customData)")
      
      // MARK: - Challenge 1 : add alerts for each action
      switch response.actionIdentifier {
      case UNNotificationDefaultActionIdentifier:
        // the user swiped to unlock
        print(actionMessage.automaticId.rawValue)
        presentActionIdAlert(for: actionMessage.automaticId.rawValue)
      case "show":
        // the user tapped our "show more info…" button
        print(actionMessage.showId.rawValue)
        presentActionIdAlert(for: actionMessage.showId.rawValue)
      default:
        break
      }
    }
    
    // you must call the completion handler when you're done
    completionHandler()
  }
}

