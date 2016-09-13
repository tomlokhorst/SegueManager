//
//  DetailViewController.swift
//  SegueExample
//
//  Created by Tom Lokhorst on 2015-03-20.
//  Copyright (c) 2015 Tom Lokhorst. All rights reserved.
//

import Cocoa

class DetailViewController: NSViewController {

  @IBOutlet weak var detailField: NSTextField!

  var displayText: String?

  override func viewDidLoad() {
    super.viewDidLoad()

    detailField.stringValue = displayText ?? "";
  }
}
