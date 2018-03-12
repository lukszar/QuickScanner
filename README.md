<p align="center">
  <img src="http://szarkowicz.info/github/quickscanner/github-header.png" width="620" max-width="90%" alt="QuickScanner logo ">
</p>

![Build passing](https://img.shields.io/badge/build-passing-brightgreen.svg?style=flat)
![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


# QuickScanner
Simple framework written in Swift to make all types of code scanning much easier.

## Features

- [x] Easy integration with Camera features
- [x] Video permission checking
- [x] Scanned codes handling with delegates
- [x] Demo provided

## Requirements

- iOS 10.0+ 
- Xcode 9.2+
- Swift 4.0+

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a simple, decentralized dependency manager for Cocoa.

You can use [Homebrew](http://brew.sh/) and install Carthage using the following command:

```bash
$ brew update
$ brew install carthage
```

To use QuickScanner in your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "lukszar/QuickScanner"
```

Run `carthage update` to build the framework and add `QuickScanner.framework` into your Xcode project.
For any help, check [Carthage manual](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application)

## Usage

Create variable for your scanner in UIViewController

```swift
var qrCodeScanner: QuickScanner!
```


in viewDidLoad() initialize scanner component with following code:
```swift
qrCodeScanner = QuickScanner(codeTypes: [CodeType.qr])
qrCodeScanner.delegate = self
```


as `codeTypes` here I used qr type, but you can use list of all types you want to be able to scan with this instance of scanner.

For easy handling scanned codes you have to implement few delegate's methods like following:

```swift
func quickScanner(_ scanner: QuickScanner, didCaptureCode code: String, type: CodeType) {
  print(code)
}

func quickScanner(_ scanner: QuickScanner, didReceiveError error: QuickScannerError) {
    print("didReceiveError: \(error)")
}

func quickScannerDidSetup(_ scanner: QuickScanner) {
    scanner.startCapturing()
}

func quickScannerDidEndScanning(_ scanner: QuickScanner) {
}

var videoPreview: UIView {
    return self.view
}
```


