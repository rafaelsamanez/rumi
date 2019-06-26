//
//  OwnerIncidenceViewController.swift
//  rumi
//
//  Created by Rafael on 6/25/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit

import os


class OwnerIncidenceViewController: UIViewController {

    var isCheck = false
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var checkButton: UIButton!
    
    var incidence: Incidence?
    
    @IBAction func sendUpdate(_ sender: Any) {
        
        
        OwnerIncidenceApi.UpdateIncidence(
            //idIncidence: (incidence?.incidenceId)!,
            idIncidence: "5d12b3114dc83453c01cfb27",
            incidenceUpdateRequest: IncidenceUpdaterequest(resolved: false, response: "La incidencia ha sido resuelta"),
            responseHandler: handleResponse,
            errorHandler: handleError)
            
        
        
    }
    
    func handleResponse(incidente: Incidence?){
        
    }
    
    
    func handleError(error:Error){
        
        let message = "Error on Organizer Request:  \(error.localizedDescription)"
        
        os_log("%@",message)
        
    }
    
    
    @IBAction func checkAction(_ sender: UIButton) {
        
        toggleCheck(button: sender)
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = incidence?.profile.name
        descriptionLabel.text = incidence?.description
        isCheck = (incidence?.isResolved)!
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
