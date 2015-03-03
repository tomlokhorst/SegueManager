//
//  MasterViewController.swift
//  SegueExample
//
//  Created by Tom Lokhorst on 2015-03-02.
//  Copyright (c) 2015 Tom Lokhorst. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

  private var textForDetail: String?

  @IBAction func openDetailAction(sender: UIButton) {

    // Save text for later
    textForDetail = "This is the detail screen!"

    // Kick off segue
    self.performSegueWithIdentifier("showDetail", sender: self)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Segue is underway, update destination ViewController with value set earlier
    if let vc = segue.destinationViewController as? DetailViewController {
      vc.displayText = textForDetail;
    }
  }
}
