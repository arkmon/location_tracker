//
//  ViewController.swift
//  location_tracker
//
//  Created by Arkadiusz Dowejko on 25/08/2017.
//  Copyright © 2017 Arkadiusz Dowejko. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var theMap: MKMapView!
    @IBOutlet weak var theLabel: UILabel!
    var polygons: [MKPolyline]?
    
    let fileLoader = TrackDrawer(fileNames: ["Track 110-03-01 02-56","Track 110-03-01 05-06", "Track 110-02-31 23-46 Bardeler Weg"])
    var myLocations: [CLLocation] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        polygons = fileLoader.getPolygons()
        
        
        theMap.delegate = self
        
        theMap.mapType = MKMapType.standard
        
        
        for polygon in self.polygons! {
            
            let spanY = polygon.coordinate.longitude - polygon.coordinate.latitude
            let span = MKCoordinateSpanMake(fabs(spanY), 0.0)
            
            let newRegion = MKCoordinateRegion(center: polygon.coordinate, span: span)
            
            theMap.setRegion(newRegion, animated: true)
            
            theMap.add(polygon)
        }
    }
  
    
    func getRandomColor() -> UIColor {
        let randomRed:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomGreen:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomBlue:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline {
            
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            
            polylineRenderer.strokeColor = getRandomColor()
            
            polylineRenderer.lineWidth = 4
            
            return polylineRenderer
            
        }
        
        return MKOverlayRenderer.self()
        
    }
    
    
    
}
