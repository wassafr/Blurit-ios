# Blurit

[![Version](https://img.shields.io/cocoapods/v/Blurit?style=flat)](http://cocoapods.org/pods/Blurit)
[![License](https://img.shields.io/cocoapods/l/Blurit?style=flat)](http://cocoapods.org/pods/Blurit)
[![Platform](https://img.shields.io/cocoapods/p/Blurit?style=flat)](http://cocoapods.org/pods/Blurit)
<a href="https://swift.org/package-manager/"><img src="https://img.shields.io/badge/SPM-supported-Green.svg?style=flat"></a>


Blurit is an SDK to anonymize picture and videos containing faces and car plates.<br>
For more information about Blurit you can visit our [website](http://blurit.io/library/ios).

## Installation

### CocoaPods

[CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) is the recommended way to add Blurit to your project.

1. Add a pod entry for Blurit to your *Podfile* :

```
pod 'Blurit_SDK'
```

2. Install the pod(s) by running `pod install`.

3. Include Blurit wherever you need it with `#import <Blurit/Blurit.h>` from Objective-C or `import Blurit` from Swift.

### Swift Package Manager

```swift
dependencies: [
  .package(url: "https://github.com/wassafr/Blurit-ios.git", from: "1.0.0")
]
```

### Manual installation

1. Download the [latest code version](https://github.com/wassafr/Blurit-ios/raw/master/Blurit.zip) or add the repository as a git submodule to your git-tracked project.

2. Include Blurit wherever you need it with `#import <Blurit_SDK/Blurit_SDK.h>` from Objective-C or `import Blurit_SDK` from Swift.

## Usage

To run the example project just open it and run. The framework is already included.
Make sure you also see [Blurit documentation](https://services.wassa.io/api/global-documentation/).
**Attention :** To use the SDK, you need a License Key you can get on the [Blurit website](http://blurit.io)

The sample code is commented and show usage examples of the SDK.

###Basics
1. Add the following import to the top of the file :

```
  import Blurit

```

 2. Instantiate a Blurit object

 ``
 bluritInstance = Blurit(licenceKey: "your license key", completion: nil)
 ```

 3. Load the detection models in the Blurit instance
 ```
 bluritInstance?.loadModels(completion: { (error) in
   if let error = error {
     print("❌ Cannot initialize Blurit \(error.localizedDescription)")
   } else {

   }
 })
 ```

 4. Make prediction from picture
 ```
 BluritService.shared.bluritInstance?.detectObjectsAsync(sourceImage: image, completion: { firstCompletionResult in

    /// Handle detected objects

 })

 ``````

 5. You can now use prediction for gender and age
 
 BluritService.shared.bluritInstance?.anonymizeAsync(sourceImage: image, predictionResult: predictionResult, completion: { secondCompletionResult in

      /// Handle blurred picture

    })

``````



## Requirements

- Xcode 13
- iOS 13

## License

Blurit is available under a commercial license. See the LICENSE file for more info.

## Author

Wassa, contact@wassa.fr
