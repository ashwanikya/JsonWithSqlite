//
//  AllMatchesViewController.swift
//  TestApp
//
//  Created by Ashwani Kumar on 24/05/20.
//  Copyright © 2020 ashwani yadav. All rights reserved.
//

import UIKit

class AllMatchesViewController: UIViewController {

    
    // MARK: Outlets
    
    @IBOutlet weak var tableViewAllMatches: UITableView!
    
    
    // MARK: Properties
    
    var allMatches: [Venue]  = []{
        didSet {
            if tableViewAllMatches != nil {
                tableViewAllMatches.reloadData()
            }
        }
    }
    private var databaseHandler = DatabaseHandler()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AllMatchesViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMatches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllMatchesTableViewCell.cellIdentifier, for: indexPath) as! AllMatchesTableViewCell

        let cellItem = allMatches[indexPath.row]
        cell.configureCell(venue: cellItem)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if self.allMatches[indexPath.row].isSelected {
            self.allMatches[indexPath.row].isSelected = false
        self.databaseHandler.deleteVenue(venueId: self.allMatches[indexPath.row].venueId)
        }else{
        self.allMatches[indexPath.row].isSelected = true
        self.databaseHandler.saveVenue(venue: self.allMatches[indexPath.row])
        }
        
        self.tableViewAllMatches.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}


