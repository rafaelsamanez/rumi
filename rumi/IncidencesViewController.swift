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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        incidenceApi.getIncidencesListGroup(
            responseHandler: handleResponse,
            errorHandler: handleError)
        
    }

    func handleResponse(incidencias: [Incidence]?){
        if let incidences = incidencias{
            
            self.incidences = incidences
            self.collectionView.reloadData()
        }
        
    }
    
    func handleError(error:Error){
        
        let message = "Error on Organizer Request:  \(error.localizedDescription)"
        
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