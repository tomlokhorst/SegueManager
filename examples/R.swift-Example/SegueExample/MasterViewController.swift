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

  // SegueManager based on the current view controller
  lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    segueManager.prepareForSegue(segue)
  }

  @IBAction func openDetailAction(sender: UIButton) {

    segueManager.performSegue(R.segue.masterViewController.showDetail) { segue in
      let detailController = segue.destinationViewController
      detailController.displayText = "This is the detail screen!"
    }
  }
}
