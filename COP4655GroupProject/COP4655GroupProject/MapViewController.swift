//
//  MapViewController.swift
//  COP4655GroupProject
//
//  Created by Nathaniel Pulido on 4/24/19.
//  Copyright © 2019 kpuli007. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    //CHANGE OFFICE LATITUDE/LONGITUDE COORDINATE HERE
    let officePoint = CLLocationCoordinate2D(latitude: 25.75, longitude: -80.34)
    
    var mapView: MKMapView!
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set zoom level
        let span = MKCoordinateSpanMake(0.09, 0.09)
        let region = MKCoordinateRegion(center: officePoint, span: span)
        mapView.setRegion(region, animated: true)
        
        //create pin
        let office = MKPointAnnotation()
        
        //needs to be fixed due to length of pin being a limiter
        office.title = "Street Address: <address> - Hours:<hours> Mo-Fr"
        office.coordinate = officePoint
        mapView.addAnnotation(office)
    }

    
    

}
