![Espresso](Resources/banner.png)

[![Version](https://img.shields.io/cocoapods/v/Espresso.svg?style=for-the-badge)](http://cocoapods.org/pods/Espresso)
![Swift](https://img.shields.io/badge/Swift-5-orange.svg?style=for-the-badge)
![iOS](https://img.shields.io/badge/iOS-11--15-green.svg?style=for-the-badge)
[![License](https://img.shields.io/cocoapods/l/Espresso.svg?style=for-the-badge)](http://cocoapods.org/pods/Espresso)

## Overview
Espresso is a Swift convenience library for iOS. Everything is better with a little coffee. ☕️

## Installation

- **Swift 4**: Version **<= 2.1.1**<br>
- **Swift 5**: Version **>= 2.2.0**

### CocoaPods
Espresso is integrated with CocoaPods!

1. Add the following to your `Podfile`:
```
use_frameworks!
pod 'Espresso', '~> 2.0'
```
2. In your project directory, run `pod install`
3. Import the `Espresso` module wherever you need it
4. Profit

Espresso is broken down into several subspecs:
- **Core**: `Foundation` classes & extensions
- **UIKit (default)**: `UIKit` classes & extensions
- **Rx**: [RxSwift](https://github.com/ReactiveX/RxSwift) classes & extensions
- **Rx-UIKit**: `UIKit`-specific [RxSwift](https://github.com/ReactiveX/RxSwift) classes & extensions. This includes the `Rx` & `UIKit` subspecs
- **All**: Includes all of the above subspecs

### Manually
You can also manually add the source files to your project.

1. Clone this git repo
2. Add all the Swift files in the `Espresso/` subdirectory to your project
3. Profit

## Espresso
Espresso adds a bunch of useful features and extensions to components commonly used while developing for Apple platforms.

Some of the more interesting things include:
- `UIAnimation` classes with promise-like chaining system
- `UIViewControllerTransition` system for easy custom `UIViewController` transitions
- `UIDevice` identification & information
- `MVVM` base classes (i.e. `ViewModel`, `UIViewModel`)
- **[RxSwift](https://github.com/ReactiveX/RxSwift)** helper classes & extensions
- Easy dependency injection setup helpers
- Crypto & digest hashing helpers
- _+ much more!_

### UIAnimation
Espresso includes a robust animation system built on `UIViewPropertyAnimator`. An animation is created with a timing curve, duration, delay, & animation closure.

```
let view = UIView()
view.alpha = 0

// Simple curve (default timing + default values)

UIAnimation {
    view.alpha = 1
}.run()

// Simple curve (default timing + custom values)

UIAnimation(duration: 0.5, delay: 0) {
    view.alpha = 1
}.run()

// Simple curve (custom)

UIAnimation(.simple(.easeOut), duration: 0.4) {
    view.alpha = 1
}.run()

// Spring curve

UIAnimation(.spring(damping: 0.9, velocity: 0.25)) {
    view.alpha = 1
}.run {
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

```
UIAnimation(duration: 0.3) {
    view.alpha = 1
}.then {
    view.backgroundColor = .red
}.run()
```

All parameters of a regular `UIAnimation` are available to you while chaining:

```
UIAnimation(duration: 0.3) {
    view.alpha = 1
}.then(.defaultSpring, duration: 0.4) {
    view.backgroundColor = UIColor.red
}.run()
```

Animations can be created and executed at a later time! Running your animations directly from an array _without_ chaining is also supported.

```
let a1 = UIAnimation {
    view.alpha = 1
}

let a2 = UIAnimation(.simple(.easeIn), duration: 0.5) {
    view.backgroundColor = UIColor.red
}

[a1, a2].run {
    print("The animations are done!")
}
```

### UIViewControllerTransition
Built on top of `UIAnimation`, Espresso's view controller transition system makes it easy to build beautiful custom transitions into your app. A simple `UIViewControllerTransition` implementation might look something like this:

```
class FadeTransition: UIViewControllerTransition {

    override func animations(using ctx: Context) -> UIAnimationGroupController {

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
- `UIFadeTransition`
- `UISlideTransition`
- `UICoverTransition`
- `UIRevealTransition`
- `UISwapTransition`
- `UIPushBackTransition`
- `UIZoomTransition`

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
