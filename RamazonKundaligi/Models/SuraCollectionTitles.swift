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
      .init(title: "Suralar", image: "book"),
      .init(title: "Duolar", image: "hand"),
      .init(title: "Saharlik \nduosi", image: "moon"),
      .init(title: "Iftorlik \nduosi", image: "sunset"),
      .init(title: "Tonggi \nzikrlar", image: "sunrise"),
      .init(title: "Kechgi \nzikrlar", image: "moon-stars"),
    ]
    return sura
  }
}
