//
//  ViewController.swift
//  Project15
//
//  Created by Jamie Brannan on 11/05/2021.
//

import UIKit

class ViewController: UIViewController {
  var imageView: UIImageView!
  var currentAnimation = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    imageView = UIImageView(image: UIImage(named: "penguin"))
    imageView.center = CGPoint(x: 512, y: 384)
    view.addSubview(imageView)
  }

  @IBAction func tappedTappedButton(_ sender: UIButton) {
    sender.isHidden = true
    
    UIView.animate(withDuration: 1, delay: 0, options: [],
       animations: {
        switch self.currentAnimation {
        case 0:
            break

        default:
            break
        }
    }) { finished in
        sender.isHidden = false /// show the sender button again when the animation is complete
    }
    
    currentAnimation += 1

    if currentAnimation > 7 {
        currentAnimation = 0
    }
    print(currentAnimation)
  }


}

