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
  private var timers = [String: NSTimer]()

  public init(viewController: UIViewController) {
    self.viewController = viewController
  }

  public func performSegue(identifier: String, handler: UIStoryboardSegue -> Void) {
    handlers[identifier] = handler
    timers[identifier] = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timeout:", userInfo: identifier, repeats: false)

    viewController.performSegueWithIdentifier(identifier, sender: viewController)
  }

    public func performSegue<T>(identifier: String, skipNavigationController: Bool = false, handler: T -> Void) {
    performSegue(identifier) { segue in
        if let vc = segue.destinationViewController as? T {
            handler(vc)
        } else if skipNavigationController {
            if let vc = (segue.destinationViewController as? UINavigationController)?.viewControllers.first as? T {
                handler(vc)
            }
        } else {
            // Note: This required Swift 1.2, in 1.0 type names are not properly shown.
            println("Performing segue '\(identifier)'.")
            println("However destinationViewController is of type '\(segue.destinationViewController.dynamicType)' not of expected type '\(T.self)'.")
      }
    }
  }

  public func performSegue(identifier : String) {
    self.performSegue(identifier, handler: { _ in })
  }

  public func prepareForSegue(segue: UIStoryboardSegue) {
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
    println("Performed segue `\(segueIdentifier)', but handler not called.")
    println("Forgot to call SeguemManager.prepareForSegue?")
  }
}
