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
