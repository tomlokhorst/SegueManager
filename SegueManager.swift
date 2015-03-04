//
//  SegueManager.swift
//  Q42
//
//  Created by Tom Lokhorst on 2014-10-14.
//

import UIKit

public class SegueManager {
  typealias Continuation = UIStoryboardSegue -> Void

  private unowned let viewController: UIViewController
  private var continuations = [String: Continuation]()

  public init(viewController: UIViewController) {
    self.viewController = viewController
  }

  public func performSegue(identifier: String, continuation: UIStoryboardSegue -> Void) {

    continuations[identifier] = continuation

    viewController.performSegueWithIdentifier(identifier, sender: viewController)
  }

  public func prepareForSegue(segue: UIStoryboardSegue) {
    if let segueIdentifier = segue.identifier {
      if let continuation = continuations[segueIdentifier] {
        continuation(segue)

        continuations.removeValueForKey(segueIdentifier)
      }
    }
  }
}
