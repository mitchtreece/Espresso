![Espresso](Resources/banner.png)

[![Version](https://img.shields.io/cocoapods/v/Espresso.svg?style=flat)](http://cocoapods.org/pods/Espresso)
![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![Platform](https://img.shields.io/cocoapods/p/Espresso.svg?style=flat)](http://cocoapods.org/pods/Espresso)
![iOS](https://img.shields.io/badge/iOS-10,%2011-blue.svg)
[![License](https://img.shields.io/cocoapods/l/Espresso.svg?style=flat)](http://cocoapods.org/pods/Espresso)

## Overview
Espresso is a Swift convenience library that makes common tasks a lot easier. Everything is better with coffee.

## Installation
### CocoaPods
Espresso is integrated with CocoaPods!

1. Add the following to your `Podfile`:
```
use_frameworks!
pod 'Espresso'
```
2. In your project directory, run `pod install`
3. Import the `Espresso` module wherever you need it
4. Profit

### Manually
You can also manually add the source files to your project.

1. Clone this git repo
2. Add all the Swift files in the `Espresso/` subdirectory to your project
3. Profit

## Espresso

Espresso adds a bunch of useful features and additions to both the **Foundation** & **UIKit** Swift modules.
There are too many different additions to cover in this *readme*. However, the code is well documented and fairly self-explanatory.

Some of the more interesting additions include:
- `UIViewController` & `UINavigationController` styling flow
- `UIAnimation` wrapper classes & queueing system
- `UITransition` system for custom step-based `UIViewController` transitions
- Display features & `UIScreen` extensions (safe area handling)
- Device information
- Type conversion extensions

## Contributing

Pull-requests are more than welcome. Bug fix? Feature? Open a PR and we'll get it merged in!
