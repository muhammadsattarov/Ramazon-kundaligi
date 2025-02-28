

import Foundation
import Adhan

extension Prayer {
  var localized: String {
    switch self {
    case .fajr: return "tong"
    case .sunrise: return "quyosh"
    case .dhuhr: return "peshin"
    case .asr: return "asr"
    case .maghrib: return "shom"
    case .isha: return "hufton"
    }
  }

  var icons: String {
    switch self {
    case .fajr: return "sunrise"
    case .sunrise: return "sun.max"
    case .dhuhr: return "sun.max.fill"
    case .asr: return "sunset"
    case .maghrib: return getCompatibleIcon()
    case .isha: return "moon.stars"
    }
  }

  func getCompatibleIcon() -> String {
      if #available(iOS 16, *) {
          return "moon.haze"
      } else {
          return "sun.haze"
      }
  }
}

