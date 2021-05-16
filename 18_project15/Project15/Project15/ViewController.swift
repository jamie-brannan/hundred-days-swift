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
    imageView.center = CGPoint(x: 412, y: 484) /// iPad Air 4th generation approx center
    view.addSubview(imageView)
  }
  
  @IBAction func tappedTappedButton(_ sender: UIButton) {
    sender.isHidden = true
    
    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],
                   animations: {
                    switch self.currentAnimation {
                    case 0:
                      self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2) /// scale up size of penguin
                    case 1:
                        self.imageView.transform = .identity
                    case 2:
                        self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
                    case 3:
                        self.imageView.transform = .identity
                    case 4:
                        self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                    case 5:
                        self.imageView.transform = .identity
                    case 6:
                        self.imageView.alpha = 0.1
                        self.imageView.backgroundColor = UIColor.green

                    case 7:
                        self.imageView.alpha = 1
                        self.imageView.backgroundColor = UIColor.clear
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

