

import Foundation

struct CalendarHeaderModel {
  let title: String
  let image: String

  static func mockData() -> [CalendarHeaderModel] {
    return [
      .init(title: "Ramazon", image: "moon"),
      .init(title: "Sana", image: "calendar"),
      .init(title: "Saharlik", image: "moon.haze"),
      .init(title: "Iftorlik", image: "sunset")
    ]
  }
}
