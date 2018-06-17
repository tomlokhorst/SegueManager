//
//  DetailViewController.swift
//  SegueExample
//
//  Created by Tom Lokhorst on 2017-01-04.
//  Copyright © 2017 Tom Lokhorst. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var detailLabel: UILabel!

  var displayText: String?

  override func viewDidLoad() {
    super.viewDidLoad()

    detailLabel.text = displayText;
  }
}
