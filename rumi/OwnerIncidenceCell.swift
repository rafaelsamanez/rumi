//
//  OwnerIncidenceCell.swift
//  rumi
//
//  Created by Rafael on 6/25/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit

class OwnerIncidenceCell: UICollectionViewCell {
    
 
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    
    func update(from incidence: Incidence) {
        
        titleLabel.text = incidence.description
        
        nameLabel.text = incidence.profile.name
    }
}
