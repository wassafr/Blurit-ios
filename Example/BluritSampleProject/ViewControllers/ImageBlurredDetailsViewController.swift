//
//  VideoBlurredDetailsViewController.swift
//  BluritSDKSampleProject
//
//  Created by Bertrand VILLAIN on 15/10/2021.
//  Copyright © 2021 Wassa. All rights reserved.
//

import UIKit
import AVFoundation

class ImageBlurredDetailsViewController: UIViewController {
  
  @IBOutlet weak var sourceImageHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var detailImageView: UIImageView!

  var dataSource: ProcessedMediaDataSource!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    guard let sourceImage = dataSource.blurredImage else { return }
    let sourceRatio = sourceImage.size.height / sourceImage.size.width
    sourceImageHeightConstraint.constant = detailImageView.frame.width * sourceRatio
    detailImageView.image = sourceImage
  }
  
  /**
   Returns to HomeViewController
   */
  @IBAction func touchUpInside(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
