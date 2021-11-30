//
//  UIViewControllerExtension.swift
//  BluritSampleProject
//
//  Created by Bertrand VILLAIN on 25/10/2021.
//

import UIKit

extension UIViewController {
  
  func alert(_ title: String?, _ message: String?, _ completion: (() -> Void)? = nil) {
    let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
      completion?()
    }))
    self.present(alertVC, animated: true, completion: nil)
  }
  
}
