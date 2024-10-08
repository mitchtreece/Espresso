![Espresso](Assets/Banner.png)

<div align="center">

![Version](https://img.shields.io/badge/Version-3.7.0-E0C39F.svg?style=for-the-badge&labelColor=AE7758)
![iOS](https://img.shields.io/badge/iOS-15+-E0C39F.svg?style=for-the-badge&labelColor=AE7758)
![macOS](https://img.shields.io/badge/macOS-13+-E0C39F.svg?style=for-the-badge&labelColor=AE7758)
![Swift](https://img.shields.io/badge/Swift-5.7-E0C39F.svg?style=for-the-badge&labelColor=AE7758)
![Xcode](https://img.shields.io/badge/Xcode-15-E0C39F.svg?style=for-the-badge&labelColor=AE7758)

</div>

# Espresso

Swift convenience library for iOS 📱<br>
Everything is better with a little coffee ☕️

## Installation

### SPM

The easiest way to get started is by installing via Xcode. Just add Espresso as a Swift package & choose the modules you want.

If you're adding Espresso as a dependency of your own Swift package, just add a package entry to your dependencies.

```
.package(
    name: "Espresso",
    url: "https://github.com/mitchtreece/Espresso",
    .upToNextMajor(from: .init(3, 0, 0))
)
```

Espresso is broken down into several modules making it quick & easy to pick and choose exactly what you need.

- `Espresso`: Core classes, extensions, & dependencies
- `EspressoUI`: UIKit & SwiftUI classes, extension, & dependencies
- `EspressoPromise`: [PromiseKit](https://github.com/mxcl/PromiseKit) classes, extensions, & dependencies

### CocoaPods

As of Espresso `3.1.0`, CocoaPods support has been dropped in favor of SPM. If you're depending on an Espresso version prior to `3.1.0`, you can still integrate using CocoaPods.

```
pod 'Espresso', '~> 3.1.0'
```

## Usage

Espresso adds a bunch of useful features and extensions to components commonly used while developing for Apple platforms.

Some of the more interesting things include:
- `UIAnimation` classes with a promise-like chaining system
- `UIViewControllerTransition` system for easy custom `UIViewController` transitions
- `AppleDevice` identification & information
- `MVVM` base classes (i.e. `ViewModel`, `UIViewModelView`, `UIViewModelViewController`)
- `Combine` helper classes & extensions
- Crypto & digest hashing helpers
- User authentication (Face ID, Touch ID, Passcode) helpers
- _+ much more!_

### UIAnimation

Espresso includes a robust animation system built on top of `UIViewPropertyAnimator`. An animation is created with a timing curve, duration, delay, & animation closure.

```swift
let view = UIView()
view.alpha = 0

// Simple curve (default timing + default values)

UIAnimation {
    view.alpha = 1
}.start()

// Simple curve (default timing + custom values)

UIAnimation(duration: 0.5, delay: 0) {
    view.alpha = 1
}.start()

// Simple curve (custom)

UIAnimation(.simple(.easeOut), duration: 0.4) {
    view.alpha = 1
}.start()

// Spring curve

UIAnimation(.spring(damping: 0.9, velocity: 0.25)) {
    view.alpha = 1
}.start {
    print("The animation is done!")
}
```

The following timing curves are currently supported:

- `simple`
- `cubicBezier`
- `spring`
- `defaultSpring`
- `material`
- `custom`

`UIAnimation` also supports animation _chaining_. This let's you easily define a series of animations to run in succession (similar to a key-frame animation) using a promise-like syntax.

```swift
UIAnimation(duration: 0.3) {
    view.alpha = 1
}.then {
    view.backgroundColor = .red
}.start()
```

All parameters of a regular `UIAnimation` are available to you while chaining:

```swift
UIAnimation(duration: 0.3) {
    view.alpha = 1
}.then(.defaultSpring, duration: 0.4) {
    view.backgroundColor = UIColor.red
}.start()
```

Animations can be created and executed at a later time! Running your animations directly from an array _without_ chaining is also supported.

```swift
let a1 = UIAnimation {
    view.alpha = 1
}

let a2 = UIAnimation(.simple(.easeIn), duration: 0.5) {
    view.backgroundColor = UIColor.red
}

[a1, a2].start {
    print("The animations are done!")
}
```

### UIViewControllerTransition

Built on top of `UIAnimation`, Espresso's view controller transition system makes it easy to build beautiful custom transitions into your app. A simple `UIViewControllerTransition` implementation might look something like this:

```swift
class CustomFadeTransition: UIViewControllerTransition {

    public override func animations(using ctx: Context) -> UIAnimationGroupController {

        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.containerView
        let context = ctx.context

        return UIAnimationGroupController(setup: {

            destinationVC.view.alpha = 0
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            container.addSubview(destinationVC.view)

        }, animations: {

            UIAnimation {
                destinationVC.view.alpha = 1
            }

        }, completion: {

            context.completeTransition(!context.transitionWasCancelled)

        })

    }

}
```

There's only one function that _needs_ to be overridden from a transition subclass, `animations(using:)`. This function provides you with contextual information about the transition, and expects you to return a `UIAnimationGroupController` containing setup, animation, & completion closures.

To present your view controller using a transition, set it's `transition` property before presentation. Helper functions on `UIViewController` & `UINavigationController` have also been added:

```swift
let transition = CustomFadeTransition()

present(
    viewController, 
    using: transition
)

navigationController.push(
    viewController, 
    using: transition
)
```

The following view controller transitions are included with Espresso:
- `UIFadeTransition`
- `UISlideTransition`
- `UICoverTransition`
- `UIRevealTransition`
- `UISwapTransition`
- `UIPushBackTransition`
- `UIZoomTransition`

### User Authentication

The `UserAuthenticator` class helps with authenticating a user via Face ID, Touch ID, or a passcode. An appropriate authentication type will be chosen automatically (i.e. devices that support Face ID will prefer Face ID, devices with Touch ID will use Touch ID). If Face ID & Touch ID are unavailable, passcode authentication will be used.

```swift
UserAuthenticator.authenticate(withReason: "The app needs to authenticate you.") { (success, error) in
    print("Authenticated: \(success)")
}
```

**NOTE:** `NSFaceIDUsageDescription` key _must_ be added to your **Info.plist** if you intend to authenticate via Face ID.

### Digest Hashing

Hashing extensions are available on both `Data` & `String`:

```swift
let data = Data()
let hashedData = data.hashed(using: .md5)

let string = "Hello, world!"
let hashedString = string.hashed(using: .md5)
```

The following hash types are included with Espresso:
- `md5`
- `sha1`
- `sha224`
- `sha256`
- `sha384`
- `sha512`

## Contributing

Pull-requests are more than welcome. Bug fix? Feature? Open a PR and we'll get it merged in! 🎉
