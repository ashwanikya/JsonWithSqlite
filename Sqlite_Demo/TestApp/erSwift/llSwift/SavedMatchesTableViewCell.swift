//
//  SavedMatchesTableViewCell.swift
//  TestApp
//
//  Created by Ashwani Kumar on 24/05/20.
//  Copyright © 2020 ashwani yadav. All rights reserved.
//

import UIKit

class SavedMatchesTableViewCell: UITableViewCell {
   
      // MARK: Outlets
       
       @IBOutlet weak var lblSavedName: UILabel!
       @IBOutlet weak var viewBack: UIView!

    
       // MARK: Properties
    
       static let cellIdentifier = "SavedMatchesTableViewCell"
       
       
       // MARK: Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewBack.round()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: Methods
    
    func configureCell(savedData: Venue) {
        self.lblSavedName.text = savedData.name
    }

}
