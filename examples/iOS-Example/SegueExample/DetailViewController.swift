//
//  DetailViewController.swift
//  SegueExample
//
//  Created by Tom Lokhorst on 2015-03-02.
//  Copyright (c) 2015 Tom Lokhorst. All rights reserved.
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
