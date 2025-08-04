//
//  GooglePlacesHandler.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 1/3/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class GooglePlacesHandler: NSObject {
    
    // MARK: - Internal Properties
    
    static let shared = GooglePlacesHandler()
    internal let kPlacesAPIKey = kGOOGLEMAPKEY
    internal let kMapsAPIKey = kGOOGLEMAPKEY
    
    // MARK: - Internal Methods
    
    func provideAPIKey() {
        GMSServices.provideAPIKey(kMapsAPIKey)
        GMSPlacesClient.provideAPIKey(kPlacesAPIKey)
    }
    
    func placeAutocompleteQuery(_ query: String, callback: @escaping ([GMSAutocompletePrediction]?, Error?) -> Void) {
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter // You can adjust this as needed (e.g. .address, .establishment)

        let token = GMSAutocompleteSessionToken.init()

        GMSPlacesClient.shared().findAutocompletePredictions(fromQuery: query,
                                                             filter: filter,
                                                             sessionToken: token) { predictions, error in
            callback(predictions, error)
        }
    }
    
    func placeMetaInfo(_ placeId: String, callback: @escaping (GMSPlaceResultCallback)) {
        let placeID = placeId
        let placesClient = GMSPlacesClient()
        placesClient.lookUpPlaceID(placeID, callback: { (place, error) -> Void in
            callback(place, error)
        })
    }
    
    func googleMapsiOSSDKReverseGeocoding(from locationCoordinate: CLLocationCoordinate2D, callback:@escaping (GMSReverseGeocodeCallback)) {
        let aGMSGeocoder: GMSGeocoder = GMSGeocoder()
        aGMSGeocoder.reverseGeocodeCoordinate(CLLocationCoordinate2DMake(locationCoordinate.latitude, locationCoordinate.longitude)) { (gmsReverseGeocodeResponse, error) in
            callback(gmsReverseGeocodeResponse, error)
        }
    
    }
}
