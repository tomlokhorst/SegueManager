//
//  ViewControllers.swift
//  SegueManager
//
//  Created by Tom Lokhorst on 2016-01-23.
//  Copyright © 2016 nonstrict. All rights reserved.
//

import UIKit

public protocol SeguePerformer {
  var segueManager: SegueManager { get }
}

extension SeguePerformer {
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

public class SegueManagerViewController : UIViewController, SeguePerformer {
  public lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()

  override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    segueManager.prepareForSegue(segue)
  }
}

public class SegueManagerCollectionViewController : UICollectionViewController, SeguePerformer {
  public lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()

  override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    segueManager.prepareForSegue(segue)
  }
}

public class SegueManagerNavigationController : UINavigationController, SeguePerformer {
  public lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()

  override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    segueManager.prepareForSegue(segue)
  }
}

public class SegueManagerTableViewController : UITableViewController, SeguePerformer {
  public lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()

  override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    segueManager.prepareForSegue(segue)
  }
}
