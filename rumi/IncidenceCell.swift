//
//  IncidenceCell.swift
//  rumi
//
//  Created by Rafael on 6/23/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit

class IncidenceCell: UICollectionViewCell {
    
   
    @IBOutlet weak var namegroupLabel: UILabel!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    
    func update(from incidence: Incidence) {
       
        
        nameLabel.text = incidence.description
    }
    
    
    func updateGroup(from group: Group) {
        
        
        namegroupLabel.text = group.participants[0].name
    }
    
}

