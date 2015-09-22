<img src="https://cloud.githubusercontent.com/assets/75655/6469027/8ef96b9e-c1d9-11e4-87a1-b76bfa3b820d.png" width="234" alt="SegueManager">
<hr>

With `SegueManager` it's easy to programatically perform segues and update the destinationViewController.
The following example demonstrates how to perform a segue and set a view model:

```swift
segueManager.performSegue("showDetails") { (details: DetailsViewController) in
  details.viewModel = DetailsViewModel("This is the details view model")
}
```

See the full [iOS example](https://github.com/tomlokhorst/SegueManager/blob/develop/examples/iOS-Example/SegueExample/MasterViewController.swift), or read below for usage instructions.

Installation
------------

### CocoaPods

SegueManager is available for both iOS and OS X. Using [CocoaPods](http://cocoapods.org), SegueManager can be integrated into your Xcode project by specifying it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'SegueManager'
```

Then, run the following command:

```bash
$ pod install
```


### Manual

SegueManager is just a single file, so instead of using CocoaPods, you could also just copy it into your project:

 - [SegueManager.swift](https://github.com/tomlokhorst/SegueManager/blob/develop/src/ios/SegueManager.swift) for iOS
 - [SegueManager.swift](https://github.com/tomlokhorst/SegueManager/blob/develop/src/osx/SegueManager.swift) for OSX


Usage
---------

Follow these steps to start using SegueManager:

1. On your ViewController, create a `SegueManager`, instantiated with `self`.
2. Override `prepareForSegue` and call SegueManager.

```swift
import SegueManager

class MasterViewController: UIViewController {

  var segueManager: SegueManager!

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    // Create a segue manager based on the current view controller
    segueManager = SegueManager(viewController: self)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    segueManager.prepareForSegue(segue)
  }
}
```

After this setup, simply call `performSegue` on the SegueManager and pass it a handler. Make sure you specify the type of the destination ViewController, since that can not be inferred:

```swift
segueManager.performSegue("showDetails") { (details: DetailsViewController) in
  details.viewModel = DetailsViewModel("This is the details view model")
}
```
The handler will be called after the destination ViewController has been instantiated, but before its view has been loaded or any animations start.

Also see the original blog post: [Easy Storyboard segues in Swift](http://tomlokhorst.tumblr.com/post/104358251649/easy-storyboard-segues-in-swift).


Segue identifiers
-----------------

_Side note:_
I'm not really a fan of using string literals as segue identifiers. This can easily break when renaming segues in a storyboard.

To fix that, I use the [`R.swift`](https://github.com/mac-cain13/R.swift) tool to get strongly typed segue identifiers. Using `R.swift` the example above becomes:

```swift
segueManager.performSegue(R.segue.showDetails) { (details: DetailsViewController) in
  details.viewModel = DetailsViewModel("This is the details view model")
}
```


Releases
--------

 - **1.0.0** - 2015-09-11 - Swift 2 support
 - 0.9.1 - 2015-08-13 - Support for nested `UINavigationController` in destination
 - 0.9.0 - 2015-03-20 - Print warning when forgot to call perpareForSegue
 - **0.5.0** - 2015-03-05 - Initial public release
 - 0.0.0 - 2014-10-12 - Initial private version for project at [Q42](http://q42.com)


Licence & Credits
-----------------

SegueManager is written by [Tom Lokhorst](https://twitter.com/tomlokhorst) of [Q42](http://q42.com) and available under the [MIT license](https://github.com/tomlokhorst/SegueManager/blob/develop/LICENSE), so feel free to use it in commercial and non-commercial projects.

