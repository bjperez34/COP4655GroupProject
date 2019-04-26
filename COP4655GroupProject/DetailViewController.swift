//
//  DetailViewController.swift
//  kpuli007-06
//
//  Created by Nathaniel Pulido on 4/26/19.
//  Copyright © 2019 kpuli007. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeInField: UITextField!
    @IBOutlet var timeOutField: UITextField!
    @IBOutlet var notesField: UITextView!
    @IBOutlet var BackButton: UIButton!
    var visit: Visit!
    
    /* Because I embedded this in a separate navigation view, it lost the automatic "Back" functionality. So I have to manually dismiss it by calling the parent view controller and telling it to dismiss this view. */
    @IBAction func dismiss(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dateText = visit.date?.description
        let dateNeeded = dateText?.substring(to: (dateText?.index((dateText?.startIndex)!, offsetBy: 10))!)
        dateLabel.text = dateNeeded
        timeInField.text = visit.timeIn
        timeOutField.text = visit.timeOut
        notesField.text = visit.notes
    }
    
    //Save the changes to the contact when the view disappears
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        visit.timeIn = timeInField.text!
        visit.timeOut = timeOutField.text!
        visit.notes = notesField.text!
        do {
            try VisitStore.instance.persistentContainer.viewContext.save()
        }
        catch _ {
            exit(1)
        }
        
    }
    
    
}
