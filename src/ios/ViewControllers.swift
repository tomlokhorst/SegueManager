//
//  ViewControllers.swift
//  SegueManager
//
//  Created by Tom Lokhorst on 2016-01-23.
//  Copyright © 2016 nonstrict. All rights reserved.
//

import UIKit

public protocol HasSegueManager {
  var segueManager: SegueManager { get }
}

extension HasSegueManager {
  public func performSegue(identifier: String, handler: UIStoryboardSegue -> Void) {
    segueManager.performSegue(identifier, handler: handler)
  }

  public func performSegue<T>(identifier: String, handler: T -> Void) {
    segueManager.performSegue(identifier, handler: handler)
  }

  public func performSegue(identifier: String) {
    segueManager.performSegue(identifier)
  }
}

public class SegueManagerViewController : UIViewController, HasSegueManager {
  public lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()

  override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    segueManager.prepareForSegue(segue)
  }
}

public class SegueManagerCollectionViewController : UICollectionViewController, HasSegueManager {
  public lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()

  override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    segueManager.prepareForSegue(segue)
  }
}

public class SegueManagerNavigationController : UINavigationController, HasSegueManager {
  public lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()

  override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    segueManager.prepareForSegue(segue)
  }
}

public class SegueManagerTableViewController : UITableViewController, HasSegueManager {
  public lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()

  override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    segueManager.prepareForSegue(segue)
  }
}
