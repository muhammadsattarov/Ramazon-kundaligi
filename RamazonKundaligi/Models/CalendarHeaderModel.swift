

import Foundation

struct CalendarHeaderModel {
  let title: String
  let image: String

  static func mockData() -> [CalendarHeaderModel] {
    return [
      .init(title: "ramazon", image: "moon"),
      .init(title: "sana", image: "calendar"),
      .init(title: "saharlik", image: getCompatibleIcon()),
      .init(title: "iftorlik", image: "sunset")
    ]
  }

  static func getCompatibleIcon() -> String {
      if #available(iOS 16, *) {
          return "moon.haze"
      } else {
          return "moon.stars"
      }
  }
}
