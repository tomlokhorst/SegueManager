//
//  MasterViewController.swift
//  SegueExample
//
//  Created by Tom Lokhorst on 2015-03-20.
//  Copyright (c) 2015 Tom Lokhorst. All rights reserved.
//

import Cocoa

class MasterViewController: NSViewController {

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
    if let detail = segue.destinationController as? DetailViewController {
      detail.displayText = "This is the detail window!"
    }
  }

  @IBAction func openDetailAction(sender: NSButton) {

    self.performSegueWithIdentifier("showDetail", sender: self)
  }
}

