//
//  MasterViewController.swift
//  SegueExample
//
//  Created by Tom Lokhorst on 2015-03-20.
//  Copyright (c) 2015 Tom Lokhorst. All rights reserved.
//

import Cocoa
import SegueManager

class MasterViewController: NSViewController {

  var segueManager: SegueManager!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    // Create a segue manager based on the current view controller
    segueManager = SegueManager(viewController: self)
  }

  override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
    segueManager.prepareForSegue(segue)
  }

  @IBAction func openDetailAction(sender: NSButton) {

    segueManager.performSegue("showDetail") { (detail: DetailViewController) in
      detail.displayText = "This is the detail window!"
    }
  }
}
