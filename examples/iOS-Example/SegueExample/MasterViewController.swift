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

  lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    segueManager.prepare(for: segue)
  }

  @IBAction func openDetailAction(_ sender: UIButton) {

    segueManager.performSegue(withIdentifier: "showDetail") { (detail: DetailViewController) in
      detail.displayText = "This is the detail screen!"
    }
  }
}
