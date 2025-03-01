

import Foundation

// MARK: - Ramazon taqvimi modeli
struct RamazonTaqvim: Codable {
    let region: String
    let district: String
    let times: [PrayerTime]
}

// MARK: - Har bir kunning saharlik va iftorlik vaqtlari
struct PrayerTime: Codable {
    let date_time: String
    let saharlik: String
    let iftorlik: String
}

extension RamazonTaqvim {
  static var ramadanCount: [Int]? {
    return Array(1...30)
  }
}
