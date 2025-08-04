//
//  ConcernRequestViewController+LocationManager.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 2/1/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

// MARK: - Location Delegate

extension ConcernRequestViewController: CLLocationManagerDelegate {
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        locationManager.requestAlwaysAuthorization()
    }
    
    func checkLocationService() {
        
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            if checkLocationAuthorization() {
                locationManager.startUpdatingLocation()
            }
        } else {
            showLocationSettingPage()
        }
    }
    
    func checkLocationAuthorization() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            return true
        case .denied:
            showLocationSettingPage()
            return false
        case .notDetermined:
            return false
        case .restricted:
            return false
        case .authorizedAlways:
            return true
        }
    }
    
    func updateGoogleMapUsingLocation(_ location: CLLocation) {
            self.locationManager.stopUpdatingLocation()
    }
    
    func stopLocationUpdate() {
        self.locationManager.stopUpdatingLocation()
        self.locationManager = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Found user's location: \(location)")
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
        } else {
            if locationManager.location != nil {
                locationManager.startUpdatingLocation()
            }
        }
        
    }
}

extension ConcernRequestViewController {
    
    func showLocationSettingPage () {
        let alertView = AlertView(title: LocalizedStrings.locationService, message: LocalizedStrings.locationAccessMessage, okButtonText: LocalizedStrings.gotoSettting, cancelButtonText: AlertMessage.Cancel) { (_, button) in
            if button == .other {
                UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
        }
        alertView.show(animated: true)
    }
}
