![Director](Resources/banner.png)

[![Version](https://img.shields.io/cocoapods/v/Director.svg?style=for-the-badge)](http://cocoapods.org/pods/Director)
[![SPM](https://img.shields.io/badge/spm-coming_soon-orange.svg?style=for-the-badge)](https://swift.org/package-manager)
![Swift](https://img.shields.io/badge/Swift-5.1-orange.svg?style=for-the-badge)
![iOS](https://img.shields.io/badge/iOS-11--13-green.svg?style=for-the-badge)
[![License](https://img.shields.io/cocoapods/l/Director.svg?style=for-the-badge)](http://cocoapods.org/pods/Director)

## Overview
Director is a lightweight coordinator library written for Swift. 🎬

**NOTE**: This library was built for Swift 5.1 & iOS 13. To run the example project, you must target iOS 13 - which requires the Xcode 11 beta.

## Installation
### CocoaPods
```
pod 'Director', '~> 1.0.0'
```

### Swift Package Manager
**Coming Soon**

## Coordinators
Coordinators helps consolidate and manage view display state. They are used to define an application's path in chunks,
while keeping navigation logic separate from app & view logic. Coordinators manage the navigation of *only* what they're
concerned with. Multiple coordinators can live in a single navigation stack, each managing a slice of the stack's views.
Likewise, a coordinator can be associated with as many (or as few) views as needed.

![Graph #1](Resources/graph_1.png)

## Director
Director is a lightweight coordinator implementation that helps keep your application's navigation paths simple & reusable.
The library consists of three main components:

- `SceneDirector`
- `SceneCoordinator`
- `ViewCoordinator`

### SceneDirector
`SceneDirector` is a scene-level class that manages a scene's window & initial view coordinator presentation.
Depending on your target iOS version, it's initialized & started on application launch *or* scene connection.

**AppDelegate (iOS 12)**

```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var director: SceneDirector?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        self.director = SceneDirector(
            ExampleSceneCoordinator(),
            window: self.window!
        ).start()

        return true

    }

}
```

**SceneDelegate (iOS 13)**

```swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var director: SceneDirector!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }

        self.window = UIWindow(windowScene: windowScene)

        self.director = SceneDirector(
            ExampleSceneCoordinator(),
            window: self.window!
        ).start()

    }

}
```

**NOTE:** You might have noticed we initialized our window manually in the above example. Because our `SceneDirector` manages our window and initial
view presentation, we **do not** use a main storyboard. You can simply remove the storyboard file added to your project by default, and clear the "Main Interface" field in your target settings. You can continue using storyboards for your other view elements if desired. Simply load them directly from
your view coordinator subclasses.

### SceneCoordinator
`SceneCoordinator` is a root-level coordinator class that manages the initial view coordinator displayed by an application.
This should be subclassed to return an appropriate `ViewCoordinator` instance on application launch _or_ scene connection.

```swift
class ExampleSceneCoordinator: SceneCoordinator {

   override func build() -> ViewCoordinator {
       return HomeCoordinator()
   }

}
```

### ViewCoordinator
`ViewCoordinator` is a class that manages the display state, navigation path, and presentation / dismissal logic for a set of related views.

```swift
class HomeCoordinator: ViewCoordinator {

   override func build() -> UIViewController {

       let vc = HomeViewController()
       vc.delegate = self
       return vc

   }

}
```

We want to abstract away navigation logic from the view. Instead, we let our coordinator decide how to navigate
when a user triggers actions on our view. To further enforce this separation of concerns, our view *shouldn't* know
about it's parent coordinator. **This is important.** For example, what if we wanted a generic view to be used in many
different coordinators? A protocol / delegate approach allows us to convey our user-actions to the coordinator while
keeping it generic enough for reuse.

```swift
extension HomeCoordinator: HomeViewControllerDelegate {

    func homeViewControllerDidTapDetail(_ viewController: HomeViewController) {
        push(DetailViewController())
    }

    func homeViewControllerDidTapHelp(_ viewController: HomeViewController) {
        modal(HelpViewController())
    }

}
```

#### Child Coordinators
A lot of the time our navigation path can be complicated and tedious when presenting the same views from different places
around our application. Instead of simply pushing or presenting our views modally, we can group navigation paths unrelated,
or distinctly different from the current path in other coordinators.

For example, if our `HomeCoordinator` from above needed to display a profile view with it's own navigation paths,
we could group it into a `ProfileCoordinator` and start it as a child of our `HomeCoordinator`.

```swift
extension HomeCoordinator: HomeViewControllerDelegate {

    ...

    func homeViewControllerDidTapProfile(_ viewController: HomeViewController) {
        start(child: ProfileCoordinator())
    }

}
```

**NOTE:** The way a child coordinator is presented depends on what is returned from a view coordinator's `build()`
function. If a `UIViewController` instance is returned, the parent coordinator will start & push onto it's existing
navigation stack. However, if a `UINavigationController` instance is returned, the parent will treat this coordinator
as being self-managed, and present the coordinator modally.

#### Embedded Coordinators
There are scenarios where a view coordinator might need to manage child views and their presentation manually.
A tab-bar interface is a good example of this. Our root view (the tab bar) contains several child views (its tabs) each
with their own navigation paths. To achieve this, you can use **embedded** view coordinators.

```swift
class TabCoordinator: ViewCoordinator {

    private var tabBarController: UITabBarController!
    private var redCoordinator = RedCoordinator()
    private var greenCoordinator = GreenCoordinator()
    private var blueCoordinator = BlueCoordinator()

    override func build() -> UIViewController {

        self.tabBarController = UITabBarController()
        self.tabBarController.viewControllers = buildChildren()
        return self.tabBarController

    }

    private func buildChildren() -> [UIViewController] {

        startEmbedded(children: [
            self.redCoordinator,
            self.greenCoordinator,
            self.blueCoordinator
        ])

        return [
            self.redCoordinator.rootViewController,
            self.greenCoordinator.rootViewController,
            self.blueCoordinator.rootViewController
        ]

    }

}
```

By calling `startEmbedded(child:)` or `startEmbedded(children:)`, the child view coordinators are setup without any automatic presentation logic.
This is ideal when building custom multi-view interfaces.

## SwiftUI
Director fully supports SwiftUI. Simply return a `UIHostingController` when building your view coordinator.

```swift
class SwiftUICoordinator: ViewCoordinator {

    override func build() -> UIViewController {
        return UIHostingController(rootView: MyView())
    }

}
```

## Contributing
Pull-requests are more than welcome. Bug fix? Feature? Open a PR and we'll get it merged in!
