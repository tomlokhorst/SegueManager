//
//  SegueManager+Rswift.swift
//  Q42
//
//  Created by Tom Lokhorst on 2015-12-05.
//
//

import UIKit
import Rswift

extension SegueManager {

  public func performSegue<Segue, Source, Destination>(
    segueIdentifier: StoryboardSegueIdentifier<Segue, Source, Destination>,
    handler: TypedStoryboardSegueInfo<Segue, Source, Destination> -> Void)
  {
    performSegue(segueIdentifier.identifier) { segue in
      if let typedInfo = segue.typedInfoWithIdentifier(segueIdentifier) {
        handler(typedInfo)
      }
      else {
        print("Performing segue '\(segueIdentifier.identifier)', however destinationViewController is of type '\(segue.destinationViewController.dynamicType)' not of expected type '\(Destination.self)'.")
      }
    }
  }
}