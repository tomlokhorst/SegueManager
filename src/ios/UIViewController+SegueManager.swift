//
//  UIViewController+SegueManager.swift
//  SegueManager
//
//  Created by Mathijs Kadijk on 27-12-15.
//  Copyright © 2015 nonstrict. All rights reserved.
//

import UIKit
import Rswift

public extension UIViewController {
  private struct AssociatedKeys {
    static var SegueManager = "SegueManager"
  }

  private static var segueManagerPrepareForSegueSwizzleToken: dispatch_once_t = 0

  private var viewControllerAssociatedSegueManager: SegueManager {
    if let segueManager = objc_getAssociatedObject(self, &AssociatedKeys.SegueManager) as? SegueManager {
      return segueManager
    }

    let segueManager = SegueManager(viewController: self)
    objc_setAssociatedObject(self, &AssociatedKeys.SegueManager, segueManager, .OBJC_ASSOCIATION_RETAIN)

    return segueManager
  }

  public override class func initialize() {
    // Make sure this isn't a subclass
    if self !== UIViewController.self {
      return
    }

    dispatch_once(&segueManagerPrepareForSegueSwizzleToken) {
      let originalSelector = Selector("prepareForSegue:sender:")
      let swizzledSelector = Selector("segueManager_prepareForSegue:sender:")

      let originalMethod = class_getInstanceMethod(self, originalSelector)
      let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)

      let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

      if didAddMethod {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
      } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
      }
    }
  }

  func segueManager_prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject) {
    viewControllerAssociatedSegueManager.prepareForSegue(segue)
  }

  public func performSegue(identifier: String, handler: UIStoryboardSegue -> Void) {
    viewControllerAssociatedSegueManager.performSegue(identifier, handler: handler)
  }

  public func performSegue<T>(identifier: String, handler: T -> Void) {
    viewControllerAssociatedSegueManager.performSegue(identifier, handler: handler)
  }

  public func performSegue(identifier : String) {
    performSegue(identifier, handler: { _ in })
  }

  public func performSegue<Segue, Source, Destination>(
    segueIdentifier: StoryboardSegueIdentifier<Segue, Source, Destination>,
    handler: TypedStoryboardSegueInfo<Segue, Source, Destination> -> Void) {
      viewControllerAssociatedSegueManager.performSegue(segueIdentifier, handler: handler)
  }
}
