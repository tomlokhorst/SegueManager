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
  public func performSegue(withIdentifier identifier: String, handler: @escaping (UIStoryboardSegue) -> Void) {
    segueManager.performSegue(withIdentifier: identifier, handler: handler)
  }

  public func performSegue<T>(withIdentifier identifier: String, handler: @escaping (T) -> Void) {
    segueManager.performSegue(withIdentifier: identifier, handler: handler)
  }

  public func performSegue(withIdentifier identifier: String) {
    segueManager.performSegue(withIdentifier: identifier)
  }
}

open class SegueManagerViewController : UIViewController, SeguePerformer {
  public lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()

  override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    segueManager.prepare(for: segue)
  }
}

open class SegueManagerCollectionViewController : UICollectionViewController, SeguePerformer {
  public lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()

  override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    segueManager.prepare(for: segue)
  }
}

open class SegueManagerNavigationController : UINavigationController, SeguePerformer {
  public lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()

  override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    segueManager.prepare(for: segue)
  }
}

open class SegueManagerTableViewController : UITableViewController, SeguePerformer {
  public lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()

  override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    segueManager.prepare(for: segue)
  }
}
