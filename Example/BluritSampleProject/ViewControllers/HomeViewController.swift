//
//  HomeViewController.swift
//  BluritSampleProject
//
//  Created by Bertrand VILLAIN on 21/07/2021.
//

import UIKit
import AVFoundation
import AVKit

/**
 That View Controller just list pictures or videos processed with Blurit.
 You can also edit the dataSource returned in the collectionView
 */
class HomeViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var progressView: UIProgressView!
  
  var gradientLayer: CAGradientLayer!
  var processedMediaDataSource: [ProcessedMediaDataSource] = []
  var imagePickerController = UIImagePickerController()

  override func viewDidLoad() {
    super.viewDidLoad()
    BluritService.shared.initService()
    imagePickerController.delegate = self
    self.collectionView.reloadData()
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    if let nextVC = segue.destination as? ImageBlurredDetailsViewController {
      nextVC.dataSource = sender as? ProcessedMediaDataSource
    }
  }
  
  func applyGradientForBackground() {
    guard let firstColor = UIColor(named: "PrimaryBackgroundColor"),
    let secondColor = UIColor(named: "SecondaryBackgroundColor") else { return }
    
    gradientLayer = CAGradientLayer()
    gradientLayer.frame = self.view.bounds
    gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
    self.view.layer.insertSublayer(gradientLayer, at: 0)
  }
  
  func handlePickedImage(image: UIImage) {
    if let error = BluritService.shared.startingError {
      self.alert("Blurit init error", error.localizedDescription, nil)
      return
    }

    guard BluritService.shared.serviceStarted else {
      self.alert(nil, "Service not yet started, wait a few more seconds", nil)
      return
    }

    BluritService.shared.bluritInstance?.detectObjectsAsync(sourceImage: image, completion: { firstCompletionResult in
      
      switch firstCompletionResult {
      case .success(let predictionResult):
        BluritService.shared.bluritInstance?.anonymizeAsync(sourceImage: image, predictionResult: predictionResult, completion: { secondCompletionResult in
          switch secondCompletionResult {
          case .success(let processedImage):
            let processedDataSource = ProcessedMediaDataSource(sourceImage: image, blurredImage: processedImage)
            self.processedMediaDataSource.append(processedDataSource)
            self.collectionView.reloadData()
          case .failure(let error):
            self.alert(nil, error.localizedDescription)
          }
        })
        
      case .failure(let error):
        self.alert(nil, error.localizedDescription)
      }
      
    })
    
  }
  
  func handlePickedVideo(videoUrl: URL) {
    guard BluritService.shared.serviceStarted else {
      self.alert(nil, "Service not yet started", nil)
      return
    }
    BluritService.shared.bluritInstance?.detectObjectsAsync(videoUrl: videoUrl, completion: { firstCompletionResult in
      switch firstCompletionResult {
      case .success(let predictionResult):
        BluritService.shared.bluritInstance?.anonymizeAsync(videoUrl: videoUrl, predictionResult: predictionResult, completion: { secondCompletionResult in
          switch secondCompletionResult {
          case .success(let processedVideoUrl):
            let processedDataSource = ProcessedMediaDataSource(sourceVideoUrl: videoUrl, blurredVideoUrl: processedVideoUrl, previewImage: #imageLiteral(resourceName: "film_roll"))
            self.processedMediaDataSource.append(processedDataSource)
            self.collectionView.reloadData()
          case .failure(let error):
            self.alert(nil, error.localizedDescription)
          }
        })
      case .failure(let error):
        self.alert(nil, error.localizedDescription)
      }
    })
  }
  
  //MARK: IBActions
  
  @IBAction func choosePictureTouched(_ sender: Any) {
    imagePickerController.sourceType = .savedPhotosAlbum
    imagePickerController.mediaTypes = ["public.image"]
    present(imagePickerController, animated: true, completion: nil)
  }
  
  @IBAction func chooseVideoTouched(_ sender: Any) {
    imagePickerController.sourceType = .savedPhotosAlbum
    imagePickerController.mediaTypes = ["public.movie"]
    present(imagePickerController, animated: true, completion: nil)
  }
  
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return processedMediaDataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let screenBounds = UIScreen.main.bounds
    return CGSize(width: (screenBounds.width / 2) - 24, height: (screenBounds.width / 2) - 24)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ProcessedMediaCVCell", for: indexPath) as! ProcessedMediaCVCell
    cell.loadData(dataSource: processedMediaDataSource[indexPath.item])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedMediaSource = processedMediaDataSource[indexPath.item]
    
    if selectedMediaSource.type == .image {
      self.performSegue(withIdentifier: "ImageBlurredDetailsViewController", sender: selectedMediaSource)
    } else {
      guard let videoUrl = selectedMediaSource.blurredVideoUrl else { return }
      
      let player = AVPlayer(url: videoUrl)
      
      // Create a new AVPlayerViewController and pass it a reference to the player.
      let controller = AVPlayerViewController()
      controller.player = player
      
      // Modally present the player and call the player's play() method when complete.
      present(controller, animated: true) {
        player.play()
      }
    }
    
  }
  
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    self.dismiss(animated: true, completion: nil)
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      self.handlePickedImage(image: image)
    } else if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
      self.handlePickedVideo(videoUrl: videoURL)
    }

  }
  
}
