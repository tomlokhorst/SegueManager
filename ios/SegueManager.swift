//
//  SegueManager.swift
//  Q42
//
//  Created by Tom Lokhorst on 2014-10-14.
//

import UIKit

public class SegueManager {
  typealias Handler = UIStoryboardSegue -> Void

  private unowned let viewController: UIViewController
  private var handlers = [String: Handler]()

  public init(viewController: UIViewController) {
    self.viewController = viewController
  }

  public func performSegue(identifier: String, handler: UIStoryboardSegue -> Void) {
    handlers[identifier] = handler

    viewController.performSegueWithIdentifier(identifier, sender: viewController)
  }

  public func performSegue<T>(identifier: String, handler: T -> Void) {
    performSegue(identifier) { segue in
      if let vc = segue.destinationViewController as? T {
        handler(vc)
      }
      else {
        // Note: This required Swift 1.2, in 1.0 type names are not properly shown.
        println("Performing segue '\(identifier)'.\nHowever destinationViewController is of type '\(segue.destinationViewController.dynamicType)' not of expected type '\(T.self)'.")
      }
    }
  }

  public func performSegue(identifier : String) {
    self.performSegue(identifier, handler: { _ in })
  }

  public func prepareForSegue(segue: UIStoryboardSegue) {
    if let segueIdentifier = segue.identifier {
      if let handler = handlers[segueIdentifier] {
        handler(segue)

        handlers.removeValueForKey(segueIdentifier)
      }
    }
  }
}
