//
//  MasterViewController.swift
//  SegueExample
//
//  Created by Tom Lokhorst on 2015-03-02.
//  Copyright (c) 2015 Tom Lokhorst. All rights reserved.
//

import UIKit
import SegueManager

class MasterViewController: UIViewController {

  let segueManager: SegueManager!

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    // Create a segue manager based on the current view controller
    segueManager = SegueManager(viewController: self)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    self.segueManager.prepareForSegue(segue);
  }

  @IBAction func openDetailAction(sender: UIButton) {

    segueManager.performSegue("showDetail") { segue in
      let vc = segue.destinationViewController as DetailViewController
      vc.displayText = "This is the detail screen!"
    }
  }
}
