


import Foundation

struct Dua {
  let title: String      // Name of dua
  let arabicText: String // Arabic name of dua
  let transliteration: String // Reading formation
  let meaning: String    // Meaning

  static func mockData() -> [Dua] {
    return [
      .init(title: "Saharlik duosi",
            arabicText: "نويت أن أصوم شهر رمضان من الفجر إلى غروب الشمس في سبيل الله.",
            transliteration: "saharlik_arab_matni",
            meaning: "saharlik_duosi_manosi"
           ),
      .init(title: "Iftorlik duosi",
            arabicText: "اللَّهُمَّ لَكَ صُمْتُ وَبِكَ آمَنْتُ وَعَلَيْكَ تَوَكَّلْتُ وَعَلَى رِزْقِكَ أَفْطَرْتُ فَاغْفِرْ لِي مَا قَدَّمْتُ وَمَا أَخَّرْتُ",
            transliteration: "iftorlik_arab_matni",
            meaning: "iftorlik_duosi_manosi"
           )
    ]
  }
}
