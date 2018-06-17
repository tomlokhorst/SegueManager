<img src="https://cloud.githubusercontent.com/assets/75655/6469027/8ef96b9e-c1d9-11e4-87a1-b76bfa3b820d.png" width="234" alt="SegueManager">
<hr>

With `SegueManager` it's easy to programatically perform segues and update the destination view controller.
The following example demonstrates how to perform a segue and set a view model:

```swift
segueManager.performSegue(withIdentifier: "showDetails") { (details: DetailsViewController) in
  details.viewModel = DetailsViewModel("This is the details view model")
}
```

See the full [iOS example](https://github.com/tomlokhorst/SegueManager/blob/develop/examples/iOS-Example/SegueExample/MasterViewController.swift), or read below for usage instructions.


Typed segues with R.swift
-------------------------

A major design goal of SegueManager 2.0 is to allow completely statically typed segues using [`R.swift`](https://github.com/mac-cain13/R.swift).

With R.swift the above example becomes:

```swift
self.performSegue(withIdentifier: R.segue.masterViewController.showDetails) { segue in
  segue.destination.viewModel = DetailsViewModel("This is the details view model")
}
```

Here the `segue` parameter is of type: `TypedStoryboardSegueInfo<UIStoryboardSegue, MasterViewController, DetailViewController>`, which means the `.destination` field is of the correct type.

To use R.swift together with SegueManager, include this subspec to your Podfile:

```ruby
pod 'SegueManager/R.swift'
```


Installation
------------

### CocoaPods

SegueManager is available for both iOS and OS X. Using [CocoaPods](http://cocoapods.org), SegueManager can be integrated into your Xcode project by specifying it in your `Podfile`:

```ruby
pod 'SegueManager'
```

Then, run the following command:

```bash
$ pod install
```

Usage
---------

There are two methods of using SegueManager:

1. Inherit from one of the base types: `SegueManagerViewController`, `SegueManagerTableViewController`, `SegueManagerCollectionViewController`, etc.
2. Or, if you don't want to rely on inheritance (often problematic), create a SegueManager yourself:

  1. On your ViewController, create a `SegueManager`, instantiated with `self`.
  2. Implement the `SeguePerformer` protocol
  3. Override `prepare(for:)` and call SegueManager.

```swift
import SegueManager

class MasterViewController: UIViewController, SeguePerformer {

  lazy var segueManager: SegueManager = {
    // SegueManager based on the current view controller
    return SegueManager(viewController: self)
  }()

  override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    segueManager.prepare(for: segue)
  }
}
```

After this setup, simply call `performSegue` on self and pass it a handler.

### With SegueManager only

Call `performSegue(withIdentifier)` with a string identifier and pass a handler. Make sure you specify the type of the destination ViewController, since that can not be inferred:

```swift
self.performSegue(withIdentifier: "showDetails") { (details: DetailsViewController) in
  details.viewModel = DetailsViewModel("This is the details view model")
}
```

### With SegueManager + R.swift

Call `performSegue(withIdentifier)` with a segue identifier from `R.segue.*` and pass a handler.

```swift
self.performSegue(withIdentifier: R.segue.masterViewController.showDetails) { segue in
  segue.destination.viewModel = DetailsViewModel("This is the details view model")
}
```

The handler will be called after the destination view controller has been instantiated, but before its view has been loaded or any animations start.


Releases
--------
 - **4.0.0** - 2018-05-19 - Swift 4.1 support
 - 3.1.0 - 2017-01-05 - Add tvOS support
 - **3.0.0** - 2016-09-13 - Swift 3 support
 - 2.1.0 - 2016-03-22 - Swift 2.2 support
 - **2.0.0** - 2016-02-10 - R.swift improvements
 - 1.3.0 - 2016-01-23 - Add `SegueManagerViewController` as `UIViewController` subclass
 - 1.2.0 - 2016-01-15 - Add R.swift support
 - 1.1.0 - 2015-09-22 - Added Carthage support
 - **1.0.0** - 2015-09-11 - Swift 2 support
 - 0.9.1 - 2015-08-13 - Support for nested `UINavigationController` in destination
 - 0.9.0 - 2015-03-20 - Print warning when forgot to call perpareForSegue
 - **0.5.0** - 2015-03-05 - Initial public release
 - 0.0.0 - 2014-10-12 - Initial private version for project at [Q42](http://q42.com)


Licence & Credits
-----------------

SegueManager is written by [Tom Lokhorst](https://twitter.com/tomlokhorst) of [Q42](http://q42.com) and available under the [MIT license](https://github.com/tomlokhorst/SegueManager/blob/develop/LICENSE), so feel free to use it in commercial and non-commercial projects.

