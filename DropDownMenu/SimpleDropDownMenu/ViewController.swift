//
//  ViewController.swift
//  UICreationComponent
//
//  Created by Rahul Umap on 04/02/19.
//  Copyright © 2019 Rahul Umap. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var customView: CustomView!
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.dataSource = ["rahul", "amin", "jimit", "dheeraj"]
    }
  
}

