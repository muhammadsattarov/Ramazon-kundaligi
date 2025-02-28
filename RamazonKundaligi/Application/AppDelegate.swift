


import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setupNotification()
    requestNotificationPermission()
    setupLanguage()
    return true
  }

  func requestNotificationPermission() {
      let center = UNUserNotificationCenter.current()
      center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
          if granted {
              print("✅ Notification ruxsat berildi")
          } else {
              print("❌ Notification ruxsat berilmadi")
          }
      }
  }

  func setupNotification() {
    if NotificationManager.shared.isNotificationsEnabled {
          NotificationManager.shared.scheduleAllPrayerNotifications()
      }
  }

  func setupLanguage() {
    if let savedLanguage = UserDefaults.standard.string(forKey: Constants.languageKey) {
        Bundle.setLanguage(savedLanguage)
    }
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication,
                   configurationForConnecting connectingSceneSession: UISceneSession,
                   options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication,
                   didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

