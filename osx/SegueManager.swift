//
//  SegueManager.swift
//  Q42
//
//  Created by Tom Lokhorst on 2015-03-20.
//

import Cocoa

public class SegueManager {
  typealias Handler = NSStoryboardSegue -> Void

  private unowned let viewController: NSViewController
  private var handlers = [String: Handler]()

  public init(viewController: NSViewController) {
    self.viewController = viewController
  }

  public func performSegue(identifier: String, handler: NSStoryboardSegue -> Void) {
    handlers[identifier] = handler

    viewController.performSegueWithIdentifier(identifier, sender: viewController)
  }

  public func performSegue<T>(identifier: String, handler: T -> Void) {
    performSegue(identifier) { segue in
      if let vc = segue.destinationController as? T {
        handler(vc)
      }
      else {
        // Note: This required Swift 1.2, in 1.0 type names are not properly shown.
        println("Performing segue '\(identifier)'.\nHowever destinationController is of type '\(segue.destinationController.dynamicType)' not of expected type '\(T.self)'.")
      }
    }
  }

  public func performSegue(identifier : String) {
    self.performSegue(identifier, handler: { _ in })
  }

  public func prepareForSegue(segue: NSStoryboardSegue) {
    if let segueIdentifier = segue.identifier {
      if let handler = handlers[segueIdentifier] {
        handler(segue)

        handlers.removeValueForKey(segueIdentifier)
      }
    }
  }
}
