


import Foundation

struct SuraAndDua {
  let id: Int
  let dua: [Dua]
}

struct Dua {
  let title: String      // Name of dua
  let arabicText: String // Arabic name of dua
  let transliteration: String // Reading formation
  let meaning: String    // Meaning
}


