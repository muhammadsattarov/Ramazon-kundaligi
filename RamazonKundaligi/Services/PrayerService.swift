
import Foundation
import Adhan
import CoreLocation

// MARK: - PrayerService
protocol PrayerServiceProtocol {
  func getPrayerTimes(for location: CLLocation) -> PrayerTimes?
  func getNextPrayerTime(prayers: PrayerTimes) -> (String, Date)?
}

class PrayerService: PrayerServiceProtocol {
  func getPrayerTimes(for location: CLLocation) -> PrayerTimes? {
    let coordinates = Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    var params = CalculationMethod.moonsightingCommittee.params
    params.madhab = .hanafi
    let date = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day], from: Date())
    return PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params)
  }

  func getNextPrayerTime(prayers: PrayerTimes) -> (String, Date)? {
    guard let nextPrayer = prayers.nextPrayer() else { return nil }
    return (prayerName(name: nextPrayer), prayers.time(for: nextPrayer))
  }

  private func prayerName(name: Prayer) -> String {
    switch name {
    case .fajr: return name.localized
    case .sunrise: return name.localized
    case .dhuhr: return name.localized
    case .asr: return name.localized
    case .maghrib: return name.localized
    case .isha: return name.localized
    }
  }
}
