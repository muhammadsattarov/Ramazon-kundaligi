


import UIKit

extension UILabel {

  convenience init(text: String, 
                   font: UIFont,
                   textColor: UIColor = .white,
                   textAlignment: NSTextAlignment = .left, numberOfLines: Int = 1) {
    self.init(frame: .zero)
    self.text = text
    self.font = font
    self.textColor = textColor
    self.textAlignment = textAlignment
    self.numberOfLines = numberOfLines
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}

