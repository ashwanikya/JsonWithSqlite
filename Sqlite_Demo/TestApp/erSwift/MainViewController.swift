//
//  MainViewController.swift
//  TestApp
//
//  Created by Ashwani Kumar on 24/05/20.
//  Copyright © 2020 ashwani yadav. All rights reserved.
//


import UIKit

class MainViewController: UIViewController {
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createDatabseAndTable()
        setupNavigationBarWithMenu(animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Methods
    
  private  func createDatabseAndTable() {
       let databaseHandler = DatabaseHandler()
        databaseHandler.createTableVenue()
    }
}


