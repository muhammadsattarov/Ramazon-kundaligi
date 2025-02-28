

import Foundation
import UserNotifications

class NotificationManager {
  static let shared = NotificationManager()
  private let viewModel = TimesViewModel()

  private let userDefaults = UserDefaults.standard
  private let notificationKey = "notificationsEnabled"

  /// 📌 Notification holatini olish
  var isNotificationsEnabled: Bool {
      get {
          // Agar `notificationKey` mavjud bo‘lmasa, defolt qiymat `true` qilib qo‘yiladi
          return userDefaults.object(forKey: notificationKey) == nil ? true : userDefaults.bool(forKey: notificationKey)
      }
      set {
          userDefaults.set(newValue, forKey: notificationKey)
          userDefaults.synchronize()

          if newValue {
            print("Saved")
              NotificationManager.shared.scheduleAllPrayerNotifications()
          } else {
            print("Removed")
              NotificationManager.shared.removeAllNotifications()
          }
      }
  }

  /// 📌 Barcha namoz notificationlarini rejalashtirish
  func scheduleAllPrayerNotifications() {
    print("✅ Notification yoqildi")
    setupNotifications()
  }

  /// ❌ Barcha notificationlarni o‘chirish
  func removeAllNotifications() {
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    print("❌ Notificationlar o‘chirildi")
  }

  func setupNotifications() {
    viewModel.getPrayerTimes { [weak self] prayers in
      guard let self = self else { return }
      self.viewModel.schedulePrayerNotifications(prayerTimes: prayers)
    }
  }
}
