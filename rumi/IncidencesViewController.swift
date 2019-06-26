//
//  IncidencesViewController.swift
//  rumi
//
//  Created by Rafael on 6/23/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit
import os

private let reuseIdentifier = "Cell"

class IncidencesViewController: UICollectionViewController {

    var incidences : [Incidence] = [Incidence]()
    var currentRow = 0
    
    var groups : [Group] = [Group]()
    
    
    //aca se ingresa el id del grupo
    var idGroup = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        idGroup = getGroupId()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getIncidencesByGroup()
    }
    
    
    
    //esta funcion carga el id del grupo , estaria en el login.
    func getGroupId() -> String{
        
        incidenceApi.getGroupId(
            responseHandler: handleResponseId,
            errorHandler: handleErrorId)
        
        //idGroup =  "5ceff7b6d4274235b808de7b"
        return idGroup
        
    }
    
    
    
    func getIncidencesByGroup(){
        
        //self.idGroup = groups[0].groupId!
        
        idGroup = getGroupId()
           
        incidenceApi.getIncidencesListGroup(
            idgroup: idGroup,
            responseHandler: handleResponse,
            errorHandler: handleError)
        
    }

    
    func handleResponseId(response: GroupsResponse){
        
        self.groups = response
        
        self.idGroup = response[0].groupId!
        
        self.collectionView.reloadData()
        
    }
    
    
    func handleErrorId(error:Error){
        
        let message = "Error on get IdGroup Request:  \(error.localizedDescription)"
        
        os_log("%@",message)
        
    }
    
    
    func handleResponse(incidencias: [Incidence]?){
        if let incidences = incidencias{
            
            self.incidences = incidences
            self.collectionView.reloadData()
        }
        
    }
    
    func handleError(error:Error){
        
        let message = "Error on Incidences Request:  \(error.localizedDescription)"
        
        os_log("%@",message)
        
    }
    

    
    
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
         return incidences.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! IncidenceCell
        
        cell.update(from : incidences[indexPath.row])
        cell.updateGroup(from: groups[0])
        
        
        
        
        return cell
    }

  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showIncidence" {
            let destination = segue.destination as! IncidenceViewController
            destination.incidence = incidences[currentRow]
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentRow = indexPath.row
        performSegue(withIdentifier: "showIncidence", sender: self)
    }

}
