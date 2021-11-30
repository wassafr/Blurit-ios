//
//  BluritService.swift
//  BluritSampleProject
//
//  Created by Bertrand VILLAIN on 09/08/2021.
//

import Blurit_SDK

class BluritService {
  
  let licenseKey = ""
  static let shared = BluritService()  // 2. Shared instance
  private init() {}
  
  var bluritInstance: Blurit?
  var serviceStarted = false

  /**
   The service must be initialized at the app starting
   */
  func initService() {
    bluritInstance = Blurit(licenceKey: licenseKey, completion: nil)
    DispatchQueue.global().async {
      self.bluritInstance?.loadModels(completion: { (error) in
        if let error = error {
          print("❌ Cannot initialize Blurit \(error.localizedDescription)")
        } else {
          print("Facelytics model successfully loaded ✅")
          self.serviceStarted = true
        }
      })
      
    }
  }
  
}
