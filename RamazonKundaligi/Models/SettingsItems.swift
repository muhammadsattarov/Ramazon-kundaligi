


import Foundation

struct SettingsItems {
  let icon: String
  let title: String

  static func mockData() -> [SettingsItems] {
    return [
      .init(icon: "globe", title: "app_language"),
      .init(icon: "square.and.arrow.up", title: "share_title"),
      .init(icon: "hand.thumbsup", title: "assessment_title"),
      .init(icon: "bell", title: "notification_title"),
      .init(icon: "info.circle", title: "about_app")
    ]
  }
}
