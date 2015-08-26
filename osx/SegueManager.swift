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
  private var timers = [String: NSTimer]()

  public init(viewController: NSViewController) {
    self.viewController = viewController
  }

  public func performSegue(identifier: String, handler: NSStoryboardSegue -> Void) {
    handlers[identifier] = handler
    timers[identifier] = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timeout:", userInfo: identifier, repeats: false)

    viewController.performSegueWithIdentifier(identifier, sender: viewController)
  }

  public func performSegue<T>(identifier: String, handler: T -> Void) {
    performSegue(identifier) { segue in
      if let vc = segue.destinationController as? T {
        handler(vc)
      }
      else {
        print("Performing segue '\(identifier)' however destinationController is of type '\(segue.destinationController.dynamicType)' not of expected type '\(T.self)'.")
      }
    }
  }

  public func performSegue(identifier : String) {
    self.performSegue(identifier, handler: { _ in })
  }

  public func prepareForSegue(segue: NSStoryboardSegue) {
    if let segueIdentifier = segue.identifier {
      timers[segueIdentifier]?.invalidate()
      timers.removeValueForKey(segueIdentifier)

      if let handler = handlers[segueIdentifier] {
        handler(segue)

        handlers.removeValueForKey(segueIdentifier)
      }
    }
  }

  @objc private func timeout(timer: NSTimer) {
    let segueIdentifier = timer.userInfo as? String ?? ""
    print("Performed segue `\(segueIdentifier)', but handler not called.")
    print("Forgot to call SegueManager.prepareForSegue?")
  }
}
