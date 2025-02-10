

import UIKit

class CalendarCollectionHeaderViewCell: UICollectionViewCell {
  static let reuseId = "CalendarCollectionHeaderViewCell"

  private lazy var iconImage: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleToFill
    $0.tintColor = .goldColor
    return $0
  }(UIImageView())

  private lazy var titleLabel = UILabel(
    text: "Namoz Vaqtlari",
    font: .systemFont(ofSize: 14, weight: .regular),
    textColor: .goldColor,
    textAlignment: .center
  )

  private lazy var baseStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.spacing = 3
    return $0
  }(UIStackView(arrangedSubviews: [iconImage, titleLabel]))

  // MARK: - Init
  init(image: String, title: String) {
    super.init(frame: .zero)
    iconImage.image = UIImage(systemName: image)
    titleLabel.text = title
//    setup()
//    setConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


// MARK: - Setup UI and Constraints
private extension CalendarCollectionHeaderViewCell {
//  func setup() {
//    self.backgroundColor = .clear
//    self.addSubview(baseStack)
//  }
//
//  func setConstraints() {
//    NSLayoutConstraint.activate([
//      iconImage.widthAnchor.constraint(lessThanOrEqualToConstant: 22),
//      iconImage.heightAnchor.constraint(lessThanOrEqualToConstant: 22),
//      
//      baseStack.topAnchor.constraint(equalTo: self.topAnchor),
//      baseStack.leftAnchor.constraint(equalTo: self.leftAnchor),
//      baseStack.rightAnchor.constraint(equalTo: self.rightAnchor),
//      baseStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//    ])
//  }
}
