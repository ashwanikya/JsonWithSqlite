//
//  AllMatchesTableViewCell.swift
//  TestApp
//
//  Created by Ashwani Kumar on 24/05/20.
//  Copyright © 2020 ashwani yadav. All rights reserved.
//

import UIKit

class AllMatchesTableViewCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var imageViewStar: UIImageView!
    
    
    // MARK: Properties
    
    static let cellIdentifier = "AllMatchesTableViewCell"
    
    
    // MARK: Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewBack.round()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    // MARK: Methods
       
   func configureCell(venue: Venue) {
    self.lblName.text = venue.name
    self.imageViewStar.image = venue.isSelected ? #imageLiteral(resourceName: "star_Fill") : #imageLiteral(resourceName: "star_Empty")
   }
}
