//
//  CreateIncidenceViewController.swift
//  rumi
//
//  Created by Rafael on 6/23/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import Foundation
import os
import UIKit

class CreateIncidenceViewController: UIViewController {
   
    
    @IBOutlet weak var TitleText: UITextField!
    
    
    
    @IBAction func SendAction(_ sender: Any) {
        
        guard
        let title = TitleText.text
       
        else {return}
        
        
        
        var newincidence = Incidencerequest(groupId: "144", description: title)
        
        
        
        newincidence.description = title
        
        CreateincidenceApi.CreateIncidence(
            incidenceRequest: Incidencerequest(groupId: "hola", description: title),
            responseHandler: handleResponse,
            errorHandler: handleError)
        
    }
    

    func handleResponse(incidente: Incidence?){
        
    }
    
    
    func handleError(error:Error){
        
        let message = "Error on Organizer Request:  \(error.localizedDescription)"
        
        os_log("%@",message)
        
    }

}
