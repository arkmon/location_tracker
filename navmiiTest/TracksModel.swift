//
//  TracksModel.swift
//  location_tracker
//
//  Created by Arkadiusz Dowejko on 28/08/2017.
//  Copyright © 2017 Arkadiusz Dowejko. All rights reserved.
//

import Foundation
import MapKit

class TracksModel: NSObject, XMLParserDelegate {

    private var boundaries = [CLLocationCoordinate2D]()
    
    func getFilePath(fileName: String) -> String? {
        //Generate a computer readable path
        return Bundle.main.path(forResource: fileName, ofType: "gpx")
    }
    
    func getTracks() -> [CLLocationCoordinate2D]? {
        return boundaries
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        //Only check for the lines that have a <trkpt> or <wpt> tag. The other lines don't have coordinates and thus don't interest us
        if elementName == "trkpt" || elementName == "wpt" {
            //Create a World map coordinate from the file
            let lat = attributeDict["lat"]!
            let lon = attributeDict["lon"]!
            
            boundaries.append(CLLocationCoordinate2DMake(CLLocationDegrees(lat)!, CLLocationDegrees(lon)!))
        }
    }
}
