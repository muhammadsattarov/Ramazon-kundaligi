

import UIKit


extension UIView {

  enum ScreenSizeType {
    case small  // iPhone SE, 8, 7
    case mini // iPhone X, 11 Pro, 12, 13
    case pro  // iPhone 11 Pro Max, 12 Pro Max, 13 Pro Max
    case proMax
    static func current() -> ScreenSizeType {
      let height = UIScreen.main.bounds.height

      switch height {
      case ...667: // Ekran balandligi <= 667 (kichik ekranlar)
        return .small
      case 668...812: // Ekran balandligi 668-812 (o‘rta ekranlar)
        return .mini
      case 813...852:
        return .pro
      default: // Ekran balandligi > 812 (katta ekranlar)
        return .proMax
      }
    }
  }
}
