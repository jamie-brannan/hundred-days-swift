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
  var selectedImage : String? = nil
    
  override func viewDidLoad() {
    super.viewDidLoad()
    flagImage.image = UIImage(named: selectedImage ?? "")
  }


}
