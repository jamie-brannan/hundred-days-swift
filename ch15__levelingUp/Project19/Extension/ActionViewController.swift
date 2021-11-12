//
//  ActionViewController.swift
//  Extension
//
//  Created by Jamie Brannan on 07/11/2021.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController {
  
  @IBOutlet var script: UITextView!
  var pageTitle = ""
  var pageURL = ""

  let titleScript = "alert(document.title);"

  override func viewDidLoad() {
    super.viewDidLoad()

    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addScript))
    navigationItem.rightBarButtonItems = [doneButton, addButton]
    
    if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
      if let itemProvider = inputItem.attachments?.first {
        itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
          guard let itemDictionary = dict as? NSDictionary else { return }
          guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
          self?.pageTitle = javaScriptValues["title"] as? String ?? ""
          self?.pageURL = javaScriptValues["URL"] as? String ?? ""
          
          DispatchQueue.main.async {
            self?.title = self?.pageTitle
          }
        }
      }
    }
  }
  
  @IBAction func done() {
    let item = NSExtensionItem()
    let argument: NSDictionary = ["customJavaScript": script.text]
    let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
    let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
    item.attachments = [customJavaScript]

    extensionContext?.completeRequest(returningItems: [item])
  }

  @objc func adjustForKeyboard(notification: Notification) {
      guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

      let keyboardScreenEndFrame = keyboardValue.cgRectValue
      let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

      if notification.name == UIResponder.keyboardWillHideNotification {
          script.contentInset = .zero
      } else {
          script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
      }

      script.scrollIndicatorInsets = script.contentInset

      let selectedRange = script.selectedRange
      script.scrollRangeToVisible(selectedRange)
  }

  @objc func addScript() {
    print("Add pressed")
    let titleAction = UIAlertAction(title: "alert(document.title);", style: .default) { [weak self] (action) in
      self?.script.text = action.title
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    let ac = UIAlertController(title: "Safari Scripts", message: "What script would you like?", preferredStyle: .actionSheet)
    ac.addAction(titleAction)
    ac.addAction(cancelAction)
    present(ac, animated: true)
  }
}
