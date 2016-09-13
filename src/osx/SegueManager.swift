//
//  SegueManager.swift
//  Q42
//
//  Created by Tom Lokhorst on 2015-03-20.
//

import Cocoa

public class SegueManager {
  typealias Handler = (NSStoryboardSegue) -> Void

  private unowned let viewController: NSViewController
  private var handlers = [String: Handler]()
  private var timers = [String: Timer]()

  public init(viewController: NSViewController) {
    self.viewController = viewController
  }

  public func performSegue(withIdentifier identifier: String, handler: @escaping (NSStoryboardSegue) -> Void) {
    handlers[identifier] = handler
    timers[identifier] = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timeout), userInfo: identifier, repeats: false)

    viewController.performSegue(withIdentifier: identifier, sender: viewController)
  }

  public func performSegue<T>(withIdentifier identifier: String, handler: @escaping (T) -> Void) {
    performSegue(withIdentifier: identifier) { segue in
      if let vc = segue.destinationController as? T {
        handler(vc)
      }
      else {
        print("Performing segue '\(identifier)' however destinationController is of type '\(type(of: segue.destinationController))' not of expected type '\(T.self)'.")
      }
    }
  }

  public func performSegue(withIdentifier identifier: String) {
    self.performSegue(withIdentifier: identifier, handler: { _ in })
  }

  public func prepare(for segue: NSStoryboardSegue) {
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
    print("Performed segue `\(segueIdentifier)', but handler not called.")
    print("Forgot to call SegueManager.prepareForSegue?")
  }
}

// Swift 3 renames
extension SegueManager {

  @available(*, unavailable, renamed: "performSegue(withIdentifier:handler:)")
  public func performSegue(_ identifier: String, handler: @escaping (NSStoryboardSegue) -> Void) {
    fatalError()
  }

  @available(*, unavailable, renamed: "performSegue(withIdentifier:handler:)")
  public func performSegue<T>(_ identifier: String, handler: @escaping (T) -> Void) {
    fatalError()
  }

  @available(*, unavailable, renamed: "performSegue(withIdentifier:)")
  public func performSegue(_ identifier : String) {
    fatalError()
  }

  @available(*, unavailable, renamed: "prepare(for:)")
  public func prepareForSegue(segue: NSStoryboardSegue) {
    fatalError()
  }
}
