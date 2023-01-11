![Espresso](Assets/Banner.png)

# Espresso

![iOS](https://img.shields.io/badge/iOS-13+-green.svg?style=for-the-badge)
![Swift](https://img.shields.io/badge/Swift-5-orange.svg?style=for-the-badge)
![SPM](https://img.shields.io/badge/SPM-3.0.0-orange.svg?style=for-the-badge)
[![Cocoapods](https://img.shields.io/badge/Pod-3.0.0-blue.svg?style=for-the-badge)](http://cocoapods.org/pods/Espresso)
[![License](https://img.shields.io/cocoapods/l/Espresso.svg?style=for-the-badge)](http://cocoapods.org/pods/Espresso)

Espresso is a Swift convenience library for iOS. Everything is better with a little coffee. ☕️

## Installation

### CocoaPods

Espresso is integrated with CocoaPods!

1. Add the following to your `Podfile`:
```
use_frameworks!
pod 'Espresso', '~> 3.0'
```
2. In your project directory, run `pod install`
3. Import the `Espresso` module wherever you need it
4. Profit

#### Subspecs

Espresso is broken down into several subspecs making it quick & easy to pick and choose what you need. By default, the `UIKit` subspec is installed.

- `Core`: Core classes, extensions, & dependencies
- `UI`
    - `UIKit`: [UIKit](https://developer.apple.com/documentation/uikit) classes, extensions, & dependencies
    - `SwiftUI`: [SwiftUI](https://developer.apple.com/documentation/swiftui) classes, extensions, & dependencies
- `Combine`
    - `Core`: [Combine](https://developer.apple.com/documentation/combine) classes, extensions, & dependencies
    - `UIKit`: [UIKit](https://developer.apple.com/documentation/uikit)-specific [Combine](https://developer.apple.com/documentation/combine) classes, extensions, & dependencies
- `Rx`
    - `Core`: [RxSwift](https://github.com/ReactiveX/RxSwift) classes, extensions, & dependencies
    - `UIKit` [UIKit](https://developer.apple.com/documentation/uikit)-specific [RxSwift](https://github.com/ReactiveX/RxSwift) classes, extensions, & dependencies
- `UIKit`: Aggregate subspec that includes everything related to [UIKit](https://developer.apple.com/documentation/uikit)
- `SwiftUI`: Aggregate subspec that includes everything related to [SwiftUI](https://developer.apple.com/documentation/swiftui)
- `All`: Aggregate subspec that includes **everything**

## Espresso

Espresso adds a bunch of useful features and extensions to components commonly used while developing for Apple platforms.

Some of the more interesting things include:
- `Animation` classes with promise-like chaining system
- `ViewControllerTransition` system for easy custom `UIViewController` transitions
- `UIDevice` identification & information
- `MVVM` base classes (i.e. `ViewModel`, `UIViewModel`)
- **[Combine](https://developer.apple.com/documentation/combine)** helper classes & extensions
- **[RxSwift](https://github.com/ReactiveX/RxSwift)** helper classes & extensions
- Easy dependency injection setup helpers
- Crypto & digest hashing helpers
- _+ much more!_

### Animation

Espresso includes a robust animation system built on `UIViewPropertyAnimator`. An animation is created with a timing curve, duration, delay, & animation closure.

```
let view = UIView()
view.alpha = 0

// Simple curve (default timing + default values)

Animation {
    view.alpha = 1
}.start()

// Simple curve (default timing + custom values)

Animation(duration: 0.5, delay: 0) {
    view.alpha = 1
}.start()

// Simple curve (custom)

Animation(.simple(.easeOut), duration: 0.4) {
    view.alpha = 1
}.start()

// Spring curve

Animation(.spring(damping: 0.9, velocity: 0.25)) {
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

`Animation` also supports animation _chaining_. This let's you easily define a series of animations to run in succession (similar to a key-frame animation) using a promise-like syntax.

```
Animation(duration: 0.3) {
    view.alpha = 1
}.then {
    view.backgroundColor = .red
}.start()
```

All parameters of a regular `Animation` are available to you while chaining:

```
Animation(duration: 0.3) {
    view.alpha = 1
}.then(.defaultSpring, duration: 0.4) {
    view.backgroundColor = UIColor.red
}.start()
```

Animations can be created and executed at a later time! Running your animations directly from an array _without_ chaining is also supported.

```
let a1 = Animation {
    view.alpha = 1
}

let a2 = Animation(.simple(.easeIn), duration: 0.5) {
    view.backgroundColor = UIColor.red
}

[a1, a2].start {
    print("The animations are done!")
}
```

### ViewControllerTransition

Built on top of `Animation`, Espresso's view controller transition system makes it easy to build beautiful custom transitions into your app. A simple `ViewControllerTransition` implementation might look something like this:

```
class FadeTransition: ViewControllerTransition {

    public override func animations(using ctx: Context) -> AnimationGroupController {

        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.containerView
        let context = ctx.context

        return AnimationGroupController(setup: {

            destinationVC.view.alpha = 0
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            container.addSubview(destinationVC.view)

        }, animations: {

            Animation {
                destinationVC.view.alpha = 1
            }

        }, completion: {

            context.completeTransition(!context.transitionWasCancelled)

        })

    }

}
```

There's only one function that _needs_ to be overridden from a transition subclass, `animations(using:)`. This function provides you with contextual information about the transition, and expects you to return a `AnimationGroupController` containing setup, animation, & completion closures.

To present your view controller using a transition, set it's `transition` property before presentation. Helper functions on `UIViewController` & `UINavigationController` have also been added:

```
let transition = FadeTransition()

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
- `FadeTransition`
- `SlideTransition`
- `CoverTransition`
- `RevealTransition`
- `SwapTransition`
- `PushBackTransition`
- `ZoomTransition`

### User Authentication

The `UserAuthenticator` class helps with authenticating a user via Touch ID, Face ID, or a password. An appropriate authentication type will be chosen automatically (i.e. devices that support Face ID will prefer Face ID. Devices with Touch ID will use Touch ID). If Face ID & Touch ID are unavailable, password authentication will be used.

```
UserAuthenticator.authenticate(withReason: "The app needs to authenticate you.") { (success, error) in
    print("Authenticated: \(success)")
}
```

**NOTE:** `NSFaceIDUsageDescription` key _must_ be added to your **Info.plist** if you intend to authenticate via Face ID.

### Digest Hashing

Hashing extensions are available on both `Data` & `String`:

```
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

Pull-requests are more than welcome. Bug fix? Feature? Open a PR and we'll get it merged in!
