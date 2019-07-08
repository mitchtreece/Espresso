![Espresso](Resources/banner.png)

[![Version](https://img.shields.io/cocoapods/v/Espresso.svg?style=for-the-badge)](http://cocoapods.org/pods/Espresso)
![Swift](https://img.shields.io/badge/Swift-5-orange.svg?style=for-the-badge)
![iOS](https://img.shields.io/badge/iOS-11--12-green.svg?style=for-the-badge)
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
pod 'Espresso', '~> 2.2.0'
```
2. In your project directory, run `pod install`
3. Import the `Espresso` module wherever you need it
4. Profit

Espresso is broken down into several sub-specs:
- `Core`: The default spec. Includes common `Foundation` & `UIKit` classes / helpers.
- `Mvvm`: MVVM-architecture related classes + helpers. Includes the `Core` spec.
- `RxMvvm`: MVVM / Rx classes + helpers. Includes the `Mvvm` & `Core` specs.
- `DI`: Dependency injection helpers. Includes the `Core` spec.
- `All`: All of the above specs.

### Manually
You can also manually add the source files to your project.

1. Clone this git repo
2. Add all the Swift files in the `Espresso/` subdirectory to your project
3. Profit

## Espresso
Espresso adds a bunch of useful features and additions to both the **Foundation** & **UIKit** layers used during iOS application development.
Too many components have been added to cover in this *readme*. However, the code is well documented and easy to understand.

Some of the more interesting things include:
- `UIAnimation` wrapper classes & promise-like chaining system
- `UITransition` system for easy custom `UIViewController` transitions
- `UIViewController` & `UINavigationController` styling system
- `UIScreen` extensions + display features
- `Coordinator` navigation implementation
- `MVVM` & `Rx` classes + helpers
- Dependency injection helpers
- Device identification & info
- Type conversion helpers
- User authentication helpers
- Digest hash helpers
- _+ much more!_

#### UIAnimation
Espresso includes a robust animation system built on `UIViewPropertyAnimator`. An animation is created with a timing curve, duration, delay, & animation block.

```
let view = UIView()
view.alpha = 0

// Simple curve (default timing + default values)

UIAnimation {
    view.alpha = 1
}.run()

// Simple curve (default timing + custom values)

UIAnimation(duration: 0.5, delay: 0, {
    view.alpha = 1
}).run()

// Simple curve (custom)

UIAnimation(.simple(.easeOut), duration: 0.4, {
    view.alpha = 1
}).run()

// Spring curve

UIAnimation(.spring(damping: 0.9, velocity: CGVector(dx: 0.25, dy: 0)), {
    view.alpha = 1
}).run(completion: {
    print("The animation is done!")
})
```

The following timing curves are currently supported:

- `simple`
- `cubicBezier`
- `spring`
- `material`
- `custom`

`UIAnimation` also supports animation _chaining_. This let's you easily define a series of animations to run in succession (similar to a key-frame animation) using a promise-like syntax.

```
UIAnimation(duration: 0.3, {
    view.alpha = 1
}).then {
    view.backgroundColor = UIColor.red
}.run()
```

All parameters of a regular `UIAnimation` are available to you while chaining:

```
UIAnimation(duration: 0.3, {
    view.alpha = 1
}).then(.spring(damping: 0.9, velocity: CGVector(dx: 0.25, dy: 0)), duration: 0.4, {
    view.backgroundColor = UIColor.red
}).run()
```

Animations can be created and executed at a later time! Running your animations directly from an array _without_ chaining them is also supported.

```
let a1 = UIAnimation {
    view.alpha = 1
}

let a2 = UIAnimation(.simple(.easeIn), duration: 0.5, {
    view.backgroundColor = UIColor.red
})

[a1, a2].run(completion: {
    print("The animations are done!")
})
```

#### UITransition
Built on top of `UIAnimation`, Espresso's view controller transition system makes it easy to build beautiful custom transitions into your app. A typical `UITransition` subclass looks something like this:

```
class FadeTransition: UITransition {

    override func transitionController(for transitionType: TransitionType, info: Info) -> UITransitionController {

        let sourceVC = info.sourceViewController
        let destinationVC = info.destinationViewController
        let container = info.transitionContainerView
        let context = info.context

        return UITransitionController(setup: {

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

There's only one function that _needs_ to be overridden from a transition subclass, `transitionController(transitionType:info:)`. This function provides you with information about the transition, and expects you to return a `UITransitionController` containing setup, animation, & completion blocks.

To present your view controller using a transition, helper functions on `UIViewController` & `UINavigationController` have been added:

```
let transition = FadeTransition()
self.present(myViewController, with: transition, completion: nil)
self.navigationController?.push(myViewController, with: transition)
```

The following transitions are included with Espresso:
- `UIFadeTransition`
- `UISlideTransition`
- `UICoverTransition`
- `UISwapTransition`
- `UIPushBackTransition`

#### User Authentication
The `UserAuthenticator` class helps with authenticating a user via Touch ID, Face ID, or a password.
An appropriate authentication type will be chosen automatically (i.e. devices that support Face ID will prefer Face ID.
Devices with Touch ID will use Touch ID). If Face ID & Touch ID are unavailable, password authentication will be used.

```
UserAuthenticator.authenticate(withReason: "The app needs to authenticate you.") { (success, error) in
    print("Authenticated: \(success)")
}
```

**NOTE:** `NSFaceIDUsageDescription` key _must_ be added to your **Info.plist** if you intend to authenticate via Face ID.

#### Digest Hash
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
