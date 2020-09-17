//
//  DetailViewController.swift
//  Consolidation2
//
//  Created by Jamie Brannan on 17/09/2020.
//  Copyright © 2020 Jamie Brannan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var flagImage: UIImageView!
  var selectedImage : String?
    
  override func viewDidLoad() {
    super.viewDidLoad()

    if let loadImage = selectedImage {
      flagImage.image = UIImage(named: loadImage)
      flagImage.layer.borderWidth = 2
      flagImage.layer.borderColor = UIColor.lightGray.cgColor
    }
  }


}
