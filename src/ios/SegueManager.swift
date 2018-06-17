//
//  SegueManager.swift
//  Q42
//
//  Created by Tom Lokhorst on 2014-10-14.
//

import UIKit

private struct SourceLocation {
  let file: String
  let line: Int
  let column: Int
  let function: String
}

public class SegueManager {
  typealias Handler = (UIStoryboardSegue) -> Void

  private unowned let viewController: UIViewController
  private let sourceLocation: SourceLocation
  private var handlers = [String: Handler]()
  private var timers = [String: Timer]()

  public init(
    viewController: UIViewController,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function)
  {
    self.viewController = viewController
    self.sourceLocation = SourceLocation(file: file, line: line, column: column, function: function)
  }

  public func performSegue(withIdentifier identifier: String, handler: @escaping (UIStoryboardSegue) -> Void) {
    handlers[identifier] = handler
    timers[identifier] = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(SegueManager.timeout(_:)), userInfo: identifier, repeats: false)

    viewController.performSegue(withIdentifier: identifier, sender: viewController)
  }

  public func performSegue<T>(withIdentifier identifier: String, handler: @escaping (T) -> Void) {
    performSegue(withIdentifier: identifier) { segue in
      if let vc: T = viewControllerOfType(segue.destination) {
        handler(vc)
      }
      else {
        let message = "Performing segue '\(identifier)', "
          + "however destinationViewController is of type "
          + "'\(type(of: segue.destination))' "
          + "not of expected type '\(T.self)'."

        fatalError(message)
      }
    }
  }

  public func performSegue(withIdentifier identifier: String) {
    self.performSegue(withIdentifier: identifier, handler: { _ in })
  }

  public func prepare(for segue: UIStoryboardSegue) {
    if let segueIdentifier = segue.identifier {
      timers[segueIdentifier]?.invalidate()
      timers.removeValue(forKey: segueIdentifier)

      if let handler = handlers[segueIdentifier] {
        handler(segue)

        handlers.removeValue(forKey: segueIdentifier)
      }
    }
  }

  @objc private func timeout(_ timer: Timer) {
    let segueIdentifier = timer.userInfo as? String ?? ""
    let message = "SegueManager created at \(sourceLocation.file):\(sourceLocation.line)\n"
      + "Performed segue `\(segueIdentifier)', but handler not called.\n"
      + "Forgot to call SegueManager.prepareForSegue?"

    fatalError(message)
  }
}


// Smartly select a view controller of a specific type
// For navigation and tabbar controllers, select the obvious view controller
private func viewControllerOfType<T>(_ viewController: UIViewController?) -> T? {
  if let vc = viewController as? T {
    return vc
  }
  else if let vc = viewController as? UINavigationController {
    return viewControllerOfType(vc.visibleViewController)
  }
  else if let vc = viewController as? UITabBarController {
    return viewControllerOfType(vc.viewControllers?.first)
  }

  return nil
}
