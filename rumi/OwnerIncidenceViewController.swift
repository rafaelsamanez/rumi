//
//  OwnerIncidenceViewController.swift
//  rumi
//
//  Created by Rafael on 6/25/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit

class OwnerIncidenceViewController: UIViewController {

    var isCheck = false
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var checkButton: UIButton!
    
    @IBAction func sendUpdate(_ sender: Any) {
        
        
        
    }
    
    
    @IBAction func checkAction(_ sender: UIButton) {
        
        toggleCheck(button: sender)
    }
    
    
    
     var incidence: Incidence?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = incidence?.profile.name
        descriptionLabel.text = incidence?.description
        updateImage(for: checkButton)
    }
    
    func toggleCheck(button: UIButton) {
        if incidence != nil {
            isCheck = !isCheck
            self.incidence!.resolved = isCheck
            updateImage(for: button)
        }
    }
    
    func updateImage(for button: UIButton) {
        let name = isCheck ?
            "checkTrue" : "checkFalse"
        button.imageView?.setImage(fromAsset: name)
    }

    
    
    
}
