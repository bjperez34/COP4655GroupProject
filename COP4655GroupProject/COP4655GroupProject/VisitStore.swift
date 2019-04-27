//
//  VisitStore.swift
//  kpuli007-P6
//
//  Created by Nathaniel Pulido on 4/25/19.
//  Copyright © 2019 kpuli007. All rights reserved.
//

import UIKit
import CoreData

class VisitStore {
    
    public static var instance = VisitStore()
    
    private init() {
        
    }
    
    var visitArray: [Visit] = []
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Visit")
        container.loadPersistentStores{ (description, error) in
            if let error = error {
                print ("Error setting up Core Data: (\(error)).")
            }
        }
        return container
    }()
    
    func createVisit(date: Date, timeIn: String, timeOut: String, into context: NSManagedObjectContext) -> Visit?
    {
        var visit: Visit!
        context.performAndWait {
            visit = Visit(context: context)
            visit.date = date as NSDate
            visit.timeIn = timeIn
            visit.timeOut = timeOut
            visit.notes = ""
        }
        
        return visit
    }
    
    func fetchVisits(completion: @escaping ([Visit]) -> Void)
    {
        let fetchRequest: NSFetchRequest<Visit> = Visit.fetchRequest()
        
        let viewContext = persistentContainer.viewContext
        
        viewContext.perform {
            do {
                let visits = try viewContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [Visit]
                completion(visits)
            }
            catch _
            {
                exit(1)
            }
        }
    }
    
    func setVisits(_ setTo: [Visit])
    {
        self.visitArray = setTo
    }
    
    func addVisit(_ visit: Visit)
    {
        visitArray.append(visit)
        
        do {
            try persistentContainer.viewContext.save()
        }
        catch _ {
            exit(1)
        }
    }
}

