//
//  SuraCollectionTitles.swift
//  RamazonKundaligi
//
//  Created by user on 29/01/25.
//



import Foundation

struct SuraCollectionTitles {
  let title: String
  let image: String

  static func mockData() -> [SuraCollectionTitles] {
    let sura: [SuraCollectionTitles] = [
      .init(title: "sura_title", image: "book"),
      .init(title: "dua_title", image: "hand"),
      .init(title: "morning_dua_title", image: "moon"),
      .init(title: "iftar_dua_title", image: "sunset"),
      .init(title: "morning_zikr_title", image: "sunrise"),
      .init(title: "evening_zikr_title", image: "moon-stars"),
    ]
    return sura
  }
}
