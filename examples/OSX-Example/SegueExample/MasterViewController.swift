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

  lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()

  override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
    segueManager.prepareForSegue(segue)
  }

  @IBAction func openDetailAction(sender: NSButton) {

    segueManager.performSegue("showDetail") { (detail: DetailViewController) in
      detail.displayText = "This is the detail window!"
    }
  }
}
