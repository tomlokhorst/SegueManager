//
//  SegueManager+Rswift.swift
//  Q42
//
//  Created by Tom Lokhorst on 2015-12-05.
//
//

import UIKit
import Rswift

extension HasSegueManager {
  public func performSegue<Segue, Destination>(
    segueIdentifier: StoryboardSegueIdentifier<Segue, Self, Destination>,
    handler: TypedStoryboardSegueInfo<Segue, Self, Destination> -> Void)
  {
    performSegue(segueIdentifier.identifier) { segue in

      if let typedInfo = TypedStoryboardSegueInfo(segueIdentifier: segueIdentifier, segue: segue) {
        handler(typedInfo)
      }
      else {
        let message = "Performing R.segue.???.\(segueIdentifier.identifier), "
          + "however not all types match up.\n"
          + "Requested: Segue: \(Segue.self), Source: \(Self.self), Destination: \(Destination.self).\n"
          + "Actual: Segue: \(segue.dynamicType), Source: \(segue.sourceViewController.dynamicType), Destination: \(segue.destinationViewController.dynamicType)."

        fatalError(message)
      }
    }
  }

  public func performSegue<Segue, Destination>(
    segueIdentifier: StoryboardSegueIdentifier<Segue, Self, Destination>)
  {
    performSegue(segueIdentifier) { _ in }
  }
}
