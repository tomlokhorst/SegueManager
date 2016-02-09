//
//  SegueManager+Rswift.swift
//  Q42
//
//  Created by Tom Lokhorst on 2015-12-05.
//
//

import UIKit
import Rswift

extension SeguePerformer {
  public func performSegue<Segue, Destination>(
    segueIdentifier: StoryboardSegueIdentifier<Segue, Self, Destination>,
    handler: TypedStoryboardSegueInfo<Segue, Self, Destination> -> Void)
  {
    segueManager.performSegue(segueIdentifier.identifier) { segue in

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

extension StoryboardSegue where Source : SeguePerformer {
  public func performSegue(
    handler: TypedStoryboardSegueInfo<Segue, Source, Destination> -> Void)
  {
    self.sourceViewController.segueManager.performSegue(self.identifier.identifier) { segue in

      if let typedInfo = TypedStoryboardSegueInfo(segueIdentifier: self.identifier, segue: segue) {
        handler(typedInfo)
      }
      else {
        let message = "Performing R.segue.???.\(self.identifier.identifier), "
          + "however not all types match up.\n"
          + "Requested: Segue: \(Segue.self), Source: \(Source.self), Destination: \(Destination.self).\n"
          + "Actual: Segue: \(segue.dynamicType), Source: \(segue.sourceViewController.dynamicType), Destination: \(segue.destinationViewController.dynamicType)."

        fatalError(message)
      }
    }
  }
}
