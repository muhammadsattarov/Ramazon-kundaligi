


import CoreLocation
import UIKit

// MARK: - LocationService
protocol LocationServiceProtocol {
    func getCurrentLocation(completion: @escaping (CLLocation) -> Void)
    func getAddress(latitude: Double, longitude: Double, completion: @escaping (String) -> Void)
}


class LocationService: NSObject, CLLocationManagerDelegate, LocationServiceProtocol {
  static let shared = LocationService()

  private let locationManager = CLLocationManager()
  private var completionHandler: ((CLLocation) -> Void)?
  private let geoCoder = CLGeocoder()

  override private init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }

  func getAddress(latitude: Double, longitude: Double, completion: @escaping (String) -> Void) {
    let location = CLLocation(latitude: latitude, longitude: longitude)
    geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
      guard let placemark = placemarks?.first else { return }
      if let country = placemark.country, let city = placemark.administrativeArea {
        completion("\(city), \(country)")
      }
    }
  }


  func getCurrentLocation(completion: @escaping (CLLocation) -> Void) {
    self.completionHandler = completion
    let status = locationManager.authorizationStatus

    if status == .notDetermined {
      locationManager.requestWhenInUseAuthorization()
    } else if status == .authorizedWhenInUse || status == .authorizedAlways {
      locationManager.startUpdatingLocation()
    } else {
      print("Location access denied")
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      completionHandler?(location)
      locationManager.stopUpdatingLocation()
    }
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Failed to get location: \(error.localizedDescription)")
  }

  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse || status == .authorizedAlways {
      locationManager.startUpdatingLocation()
    }
  }
}
