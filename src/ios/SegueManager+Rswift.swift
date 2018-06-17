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
    withIdentifier segueIdentifier: StoryboardSegueIdentifier<Segue, Self, Destination>,
    handler: @escaping (TypedStoryboardSegueInfo<Segue, Self, Destination>) -> Void)
  {
    segueManager.performSegue(withIdentifier: segueIdentifier.identifier) { segue in

      if let typedInfo = TypedStoryboardSegueInfo(segueIdentifier: segueIdentifier, segue: segue) {
        handler(typedInfo)
      }
      else {
        let message = "Performing R.segue.???.\(segueIdentifier.identifier), "
          + "however not all types match up.\n"
          + "Requested: Segue: \(Segue.self), Source: \(Self.self), Destination: \(Destination.self).\n"
          + "Actual: Segue: \(type(of: segue)), Source: \(type(of: segue.source)), Destination: \(type(of: segue.destination))."

        fatalError(message)
      }
    }
  }

  public func performSegue<Segue, Destination>(
    withIdentifier segueIdentifier: StoryboardSegueIdentifier<Segue, Self, Destination>)
  {
    performSegue(withIdentifier: segueIdentifier) { _ in }
  }
}

extension StoryboardSegue where Source : SeguePerformer {
  public func performSegue(
    handler: @escaping (TypedStoryboardSegueInfo<Segue, Source, Destination>) -> Void)
  {
    self.source.segueManager.performSegue(withIdentifier: self.identifier.identifier) { segue in

      if let typedInfo = TypedStoryboardSegueInfo(segueIdentifier: self.identifier, segue: segue) {
        handler(typedInfo)
      }
      else {
        let message = "Performing R.segue.???.\(self.identifier.identifier), "
          + "however not all types match up.\n"
          + "Requested: Segue: \(Segue.self), Source: \(Source.self), Destination: \(Destination.self).\n"
          + "Actual: Segue: \(type(of: segue)), Source: \(type(of: segue.source)), Destination: \(type(of: segue.destination))."

        fatalError(message)
      }
    }
  }
}
