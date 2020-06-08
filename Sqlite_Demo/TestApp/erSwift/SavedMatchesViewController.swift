//
//  SavedMatchesViewController.swift
//  TestApp
//
//  Created by Ashwani Kumar on 24/05/20.
//  Copyright © 2020 ashwani yadav. All rights reserved.
//

import UIKit

class SavedMatchesViewController: UIViewController {

    // MARK: Outlets
   
    @IBOutlet weak var tableViewSavedMatches: UITableView!

   
    // MARK: Properties
    
    var savedMatches : [Venue]  = []{
        didSet {
            if tableViewSavedMatches != nil {
                tableViewSavedMatches.reloadData()
            }
        }
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension SavedMatchesViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedMatches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedMatchesTableViewCell.cellIdentifier, for: indexPath) as! SavedMatchesTableViewCell

        let cellItem = savedMatches[indexPath.row]
        cell.configureCell(savedData: cellItem)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}


