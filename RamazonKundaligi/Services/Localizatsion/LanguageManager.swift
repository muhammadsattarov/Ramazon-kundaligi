
import UIKit

final class LanguageManager {
  static let shared = LanguageManager()

  private let userDefaults = UserDefaults.standard

  var currentLanguage: String {
    get {
      return userDefaults.string(forKey: Constants.languageKey) ?? Locale.preferredLanguages.first ?? "uz-UZ"
    }
    set {
      userDefaults.set(newValue, forKey: Constants.languageKey)
      userDefaults.synchronize()
      Bundle.setLanguage(newValue)  // Bundle tilini o‘zgartiramiz
      NotificationCenter.default.post(name: NSNotification.Name(Constants.languageChanged), object: nil)
    }
  }
}

