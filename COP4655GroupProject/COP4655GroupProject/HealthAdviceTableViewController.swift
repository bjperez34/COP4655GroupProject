//
//  HealthAdviceTableViewController.swift
//  COP4655GroupProject
//
//  Created by Bert Perez on 4/26/19.
//  Copyright © 2019 kpuli007. All rights reserved.
//

import UIKit
import CoreData

class HealthAdviceTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var managedObjectContext: NSManagedObjectContext? = nil
    
    // MARK: - table view configuration
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let amount = healthVideoFetchedResultsController.fetchedObjects?.count ?? 0
        return amount
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HealthTip", for: indexPath) as! AdviceCell
        
        let advice = healthVideoFetchedResultsController.object(at: indexPath)
        
        cell.healthTitle!.text = advice.healthVideoDescription
        
        return cell
    }
    
    // MARK: - Fetched results controller for health BodyHealthAdvice
    var healthVideoFetchedResultsController: NSFetchedResultsController<HealthVideoInfo> {
        if _healthVideoFetchedResultsController != nil {
            return _healthVideoFetchedResultsController!
        }
        let fetchRequest: NSFetchRequest<HealthVideoInfo> = HealthVideoInfo.fetchRequest()
        
        //fetchRequest.fetchBatchSize = 1
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "healthVideoDescription", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        _healthVideoFetchedResultsController = aFetchedResultsController
        
        do {
            try _healthVideoFetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _healthVideoFetchedResultsController!
    }
    var _healthVideoFetchedResultsController: NSFetchedResultsController<HealthVideoInfo>? = nil
    
    //MARK: - prepare for segue
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     //if triggered segue is the "showItem" segue
     switch segue.identifier {
     case "DetailedHealthTips"?:
     //figure out which row was tapped
     if let row = tableView.indexPathForSelectedRow?.row {
     //get item associated with row
     let detailViewController = segue.destination as! HealthAdviceDetailController
     detailViewController.showVideo(videoCode: (healthVideoFetchedResultsController.fetchedObjects?[row].healthVideoUrlCode)!)
     detailViewController.videoDescription.text = healthVideoFetchedResultsController.fetchedObjects?[row].healthVideoDescription
     }
     default:
     preconditionFailure("Unexpected Segue Identifier")
     }
     }*/
    
}
