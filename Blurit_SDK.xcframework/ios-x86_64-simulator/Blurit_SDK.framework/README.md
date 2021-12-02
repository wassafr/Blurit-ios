# Blurit SDK

## Synopsis

Blurit is an SDK to anonymize picture and videos containing faces and car plates.<br>
For more information about Blurit you can visit our [website](http://blurit.io/library/ios).

## Environment setup & installation

- XCode 12.0+
- iOS 13.0+

⚠️ Use  `git clone --recurse-submodules -j8` ⚠️

You can use the framework directly, no specific install to make.
The framework and its dependencies are automatically compilled when you Build & Run the sampleProject.

## Framework creation
To distribute Blurit in a framework through Swift Package Manager we have to create an xcframework
To generate the XCFramework just run the scheme GenerateXCFramework and recover the result in the folder Blurit-Frameworks/, then put the folder Blurit_SDK.xcframework into the proper place to deploy it for Cocoapod and SPM.

⚠️ In the case you face an issue with the generation you can check the script at GenerateBluritXCFramework.sh.

## External dependencies
- ZIPFoundation
- CoreFoundation
- Foundation
- CoreML
- MetalPetal
- VideoIO

![Dependencies](Blurit_iOS_architecture_and_dependencies.png)

### Other dependencies
- ZIPFoundation
- MobileLicenseSystem (libcryptopp)

## CPU Architectures

- arm64 arm64e  i386 are the only valid architectures
- armv7 armv7s are not supported by this framework as iOS 12 (needed for CoreML) doesn't support those architectures, so it is useless to implement them.

## Documentation 📑

We use Jazzy to generate html doc (sudo gem install jazzy)

Just run the command `jazzy .jazzy.yaml` in the terminal to generate the documentation (Swift only ⚠️)
The details of the parameters used for jazzy are located in the file .jazzy.yml

OR

`brew install sourcekitten`
To generate a mixed version from Obj C and Swift use the following script `./generatedoc.sh`

## License

Blurit is available under a commercial license. The license file is located in the Blurit pod repo.

## Author

Wassa, contact@wassa.io
