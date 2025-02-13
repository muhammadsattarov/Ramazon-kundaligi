


import Foundation

struct SettingsItems {
  let icon: String
  let title: String

  static func mockData() -> [SettingsItems] {
    return [
      .init(icon: "globe", title: "Ilova tili"),
      .init(icon: "square.and.arrow.up", title: "Ulashish"),
      .init(icon: "hand.thumbsup", title: "Baholash"),
      .init(icon: "moon", title: "Tungi rejim"),
      .init(icon: "bell", title: "Bildirishnoma"),
      .init(icon: "info.circle", title: "Dastur haqida")
    ]
  }
}
