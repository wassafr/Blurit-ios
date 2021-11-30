//
//  ProcessedMediaCVCell.swift
//  BluritSampleProject
//
//  Created by Bertrand VILLAIN on 15/10/2021.
//

import UIKit

class ProcessedMediaCVCell: UICollectionViewCell {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var heightImageConstraint: NSLayoutConstraint!
  @IBOutlet weak var playImageView: UIImageView!
  
  func loadData(dataSource: ProcessedMediaDataSource) {
    let screenBounds = UIScreen.main.bounds
    heightImageConstraint.constant = (screenBounds.width / 2) - 14
    imageView.image = dataSource.previewImage
    self.playImageView.isHidden = (dataSource.type == .image)
  }

  
  
}

class ProcessedMediaDataSource {
  
  let reuseIdentifier = "ProcessedMediaCVCell"
  
  var type: MediaType
  var previewImage: UIImage?
  
  var sourceImage: UIImage?
  var blurredImage: UIImage?
  
  var sourceVideoUrl: URL?
  var blurredVideoUrl: URL?
  
  internal init(sourceImage: UIImage, blurredImage: UIImage?) {
    self.type = .image
    self.sourceImage = sourceImage
    self.blurredImage = blurredImage
    self.previewImage = blurredImage ?? sourceImage
  }

  internal init(sourceVideoUrl: URL?, blurredVideoUrl: URL?, previewImage: UIImage) {
    self.type = .video
    self.sourceVideoUrl = sourceVideoUrl
    self.blurredVideoUrl = blurredVideoUrl
    self.previewImage = previewImage
  }
  
}

enum MediaType {
  case image
  case video
}
