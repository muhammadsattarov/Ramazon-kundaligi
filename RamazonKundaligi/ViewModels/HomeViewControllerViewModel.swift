

import Foundation
import Adhan
import CoreLocation
import UserNotifications

// MARK: - TimesViewModel
class TimesViewModel {

  private let locationService: LocationServiceProtocol
  private let prayerService: PrayerServiceProtocol

  var prayerTimes: [PrayerTimesModel] = []
  var fajr: String?
  var sunrise: String?
  var dhuhr: String?
  var asr: String?
  var maghrib: String?
  var isha: String?
  var timer: Timer?
  var nextPrayerTime: Date?
  var countryName: String?

  init(locationService: LocationServiceProtocol = LocationService.shared,
       prayerService: PrayerServiceProtocol = PrayerService()) {
    self.locationService = locationService
    self.prayerService = prayerService
  }

  func getPrayerTimes(completion: @escaping (PrayerTimes) -> Void) {
    locationService.getCurrentLocation { [weak self] location in
      guard let self = self,
            let prayers = self.prayerService.getPrayerTimes(for: location) else { return }
      completion(prayers)
    }
  }

  func showPrayerTimes(completion: @escaping (String, String, String) -> Void) {
    locationService.getCurrentLocation { [weak self] location in
      guard let self = self else { return }
      self.locationService.getAddress(latitude: location.coordinate.latitude,
                                      longitude: location.coordinate.longitude) { address in
        self.countryName = address
      }

      guard let prayers = self.prayerService.getPrayerTimes(for: location) else { return }

      if let (nextPrayerName, nextPrayerTime) = self.prayerService.getNextPrayerTime(prayers: prayers) {
        self.nextPrayerTime = nextPrayerTime
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
          guard let self = self else { return }
          let timeRemaining = nextPrayerTime.timeIntervalSinceNow
          if timeRemaining > 0 {
            completion(nextPrayerName, self.formatTimeInterval(timeRemaining), self.countryName ?? "")
          }
        }
      }

      self.prayerTimes = [
        PrayerTimesModel(prayer: .fajr, time: self.formattedPrayerTime(prayers.fajr)),
        PrayerTimesModel(prayer: .sunrise, time: self.formattedPrayerTime(prayers.sunrise)),
        PrayerTimesModel(prayer: .dhuhr, time: self.formattedPrayerTime(prayers.dhuhr)),
        PrayerTimesModel(prayer: .asr, time: self.formattedPrayerTime(prayers.asr)),
        PrayerTimesModel(prayer: .maghrib, time: self.formattedPrayerTime(prayers.maghrib)),
        PrayerTimesModel(prayer: .isha, time: self.formattedPrayerTime(prayers.isha))
      ]
    }
  }

  private func formattedPrayerTime(_ prayerTime: Date?) -> String {
    guard let prayerTime = prayerTime else { return "N/A" }
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.timeZone = TimeZone.current
    return formatter.string(from: prayerTime)
  }

  private func formatTimeInterval(_ interval: TimeInterval) -> String {
    let hours = Int(interval) / 3600
    let minutes = (Int(interval) % 3600) / 60
    let seconds = Int(interval) % 60
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
  }
}


extension TimesViewModel {
  func getGregorianAndHijriDate(completion: @escaping (String, String) -> Void) {
    let now = Date()  // Hozirgi sana

    // Gregorian yilini olish (24 mart, 2025 formatida)
    let gregorianFormatter = DateFormatter()
    gregorianFormatter.dateFormat = "d MMMM, yyyy"
    gregorianFormatter.locale = Locale(identifier: "en_US")  // Ingliz tilida
    let gregorianDate = gregorianFormatter.string(from: now)

    // Hijri yilini olish
    let hijriFormatter = DateFormatter()
    hijriFormatter.dateFormat = "d MMMM, yyyy"
    hijriFormatter.locale = Locale(identifier: "en_US")  // Arab tilida Hijri sanasini olish
    hijriFormatter.calendar = Calendar(identifier: .islamicUmmAlQura) // Hijri kalendarini sozlash
    let hijriDate = hijriFormatter.string(from: now)

    completion(gregorianDate, hijriDate)
  }
}

extension TimesViewModel {
  func schedulePrayerNotifications(prayerTimes: PrayerTimes) {
    let prayers = prayerTimes.getPrayerTimesAsDates()

    for (name, time) in prayers {
      if time > Date() { // 🔹 Faqat kelajakdagi namoz vaqtlariga notification qo‘yiladi
        scheduleNotification(namozNomi: name, vaqt: time)
      }
    }
  }

  func scheduleNotification(namozNomi: String, vaqt: Date) {
    let content = UNMutableNotificationContent()
    guard let countryName else { return }
    content.title = "\(countryName) namoz vaqti bo'ldi." // Add location name for notification
  //  content.body = namozNomi // Add prayer name for notification
    content.sound = .defaultRingtone

    let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: vaqt)
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

    let request = UNNotificationRequest(identifier: namozNomi, content: content, trigger: trigger)

    UNUserNotificationCenter.current().add(request) { error in
      if let error = error {
        print("❌ Notification qo‘shishda xatolik: \(error.localizedDescription)")
      } else {
        print("✅ \(namozNomi) uchun notification muvaffaqiyatli rejalashtirildi")
      }
    }
  }
}
