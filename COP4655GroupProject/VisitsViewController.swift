//
//  VisitsViewController.swift
//  COP4655GroupProject
//
//  Created by Nathaniel Pulido on 4/25/19.
//  Copyright © 2019 kpuli007. All rights reserved.
//

import UIKit
import CoreData

class VisitsViewController: UITableViewController {
    
    let store = VisitStore.instance
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VisitStore.instance.visitArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VisitCell", for: indexPath) as! VisitCell
        
        let cellNum = indexPath.row
        let visit = VisitStore.instance.visitArray[cellNum]
        
        let dateText = visit.date?.description
        let dateNeeded = dateText?.substring(to: (dateText?.index((dateText?.startIndex)!, offsetBy: 10))!)
        cell.dateLabel.text = dateNeeded
        cell.timeInLabel.text = visit.timeIn
        cell.timeOutLabel.text = visit.timeOut
        
        return cell
    }
    
    //Create an item and add it to the store
    //The date will be the date the button was pressed. The date cannot be changed. Deletion not supported.
    func addNewItem() {
        let newItem = VisitStore.instance.createVisit(date:Date(), timeIn: "12:00pm", timeOut: "12:00pm", into: VisitStore.instance.persistentContainer.viewContext)
        VisitStore.instance.addVisit(newItem!)
    }
    
    //Segue preparation - one for viewing an existing item, the other for creating a "default" new item and adding the prompt to it
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "displayDetails"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                let visit = VisitStore.instance.visitArray[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.visit = visit            }
        case "newVisit"?:
            addNewItem()
            let visit = VisitStore.instance.visitArray[VisitStore.instance.visitArray.count - 1]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.visit = visit
        default:
            preconditionFailure("Unexpected segue identifier!")
        }
    }
}
