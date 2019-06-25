//
//  IncidenceViewController.swift
//  rumi
//
//  Created by Rafael on 6/23/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import Foundation

import UIKit

class IncidenceViewController: UIViewController {
    
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var incidence: Incidence?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
            descriptionLabel.text = incidence?.description
        }
    }

