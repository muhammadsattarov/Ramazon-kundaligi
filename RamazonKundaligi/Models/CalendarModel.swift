

import Foundation

struct CalendarModel {
  let daynumber: String
  let dayName: String
  let saharTime: String
  let iftarTime: String

  static func mockData() -> [CalendarModel] {
    return [
      .init(daynumber: "01", dayName: "2-mart", saharTime: "06:12", iftarTime: "18:21"),
      .init(daynumber: "02", dayName: "3-mart", saharTime: "06:15", iftarTime: "18:24"),
      .init(daynumber: "03", dayName: "4-mart", saharTime: "06:17", iftarTime: "18:26"),
      .init(daynumber: "04", dayName: "5-mart", saharTime: "06:18", iftarTime: "18:28"),
      .init(daynumber: "05", dayName: "6-mart", saharTime: "06:20", iftarTime: "18:29"),
      .init(daynumber: "06", dayName: "7-mart", saharTime: "06:22", iftarTime: "18:31"),
      .init(daynumber: "07", dayName: "8-mart", saharTime: "06:23", iftarTime: "18:35"),
      .init(daynumber: "08", dayName: "9-mart", saharTime: "06:25", iftarTime: "18:36"),
      .init(daynumber: "09", dayName: "10-mart", saharTime: "06:27", iftarTime: "18:38"),
      .init(daynumber: "10", dayName: "11-mart", saharTime: "06:29", iftarTime: "18:39"),
      .init(daynumber: "11", dayName: "12-mart", saharTime: "06:31", iftarTime: "18:41"),
      .init(daynumber: "12", dayName: "13-mart", saharTime: "06:34", iftarTime: "18:42"),
    ]
  }
}
