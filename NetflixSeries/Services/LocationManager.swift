//
//  LocationManager.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 04.04.2023.
//

import SwiftUI
import MapKit
import CoreLocation

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
//    var lat: Double = 50.0755
//    var lon: Double = 14.4378
//    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.0755, longitude: 14.4378), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    var locationManager: CLLocationManager = .init()
    var geocoderManager: CLGeocoder = .init()
    
    @Published var location: CLLocation = CLLocation(latitude: 50.0755, longitude: 14.4378)
    @Published var country: String? = nil
    @AppStorage("country") var currentUserCountry: String?

    
    override init() {
        super.init()
        locationManager.delegate = self
//        checkLocationsServiceIsEnabled()
       
    }
    
//    func checkLocationsServiceIsEnabled() {
//        if CLLocationManager.locationServicesEnabled() {
//                // check if location services are enabled!!!
//        } else { return }
//    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
            print("notDetermined")
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
//            locationManager.requestLocation()
            print("authorizedAlways, .authorizedWhenInUse")
            
        @unknown default:
            break
        }
    }
    
    @MainActor
    func getCountryFromCurrentLocation() async throws {
            do {
                let geocodingResult = try await geocoderManager.reverseGeocodeLocation(location)
                if let countryName = geocodingResult.first?.country {
                    self.country = countryName
                    print(countryName)
                    currentUserCountry = countryName
                }

            } catch {
                throw LocationError.couldNotGetCountryName
            }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: Location Manager failed with error")
    }
    
    enum LocationError: LocalizedError {
        case locationServicesAreUnabled
        case couldNotGetCountryName
        
        var localizedDescription: String? {
            switch self {
            case .locationServicesAreUnabled: return "Go to settings and enable location services in order to use this feature!"
            case .couldNotGetCountryName: return "Func to get country name failed"
                
            }
        }
    }
    
    
    
}
