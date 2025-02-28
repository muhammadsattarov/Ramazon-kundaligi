

import UIKit

class SuraCollectionViewCell: UICollectionViewCell {
  static let reuseId = "SuraCollectionViewCell"
  
  private lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.textColor = .goldColor
    $0.textAlignment = .center
    $0.numberOfLines = 2
    return $0
  }(UILabel())

  private lazy var imageOfView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.image = UIImage(systemName: "sun.max")
    $0.tintColor = .goldColor
    $0.contentMode = .scaleToFill
    return $0
  }(UIImageView())

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setConstraints()
  }

  func configure(with model: SuraCollectionTitles) {
    titleLabel.text = Bundle.localizedString(forKey: model.title)
    imageOfView.image = UIImage(named: model.image)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = 15
    self.layer.masksToBounds = true
    self.backgroundColor = .fonGreenColor
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Init
private extension SuraCollectionViewCell {
  func setup() {
    self.addSubview(titleLabel)
    self.addSubview(imageOfView)
  }

  func setConstraints() {

    let space: CGFloat
    let titleFont: UIFont
    let imageSize: CGFloat

    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      space = 14
      titleFont = .systemFont(ofSize: 18, weight: .medium)
      imageSize = 23
    case .mini:
      space = 15
      titleFont = .systemFont(ofSize: 20, weight: .medium)
      imageSize = 25
    case .pro:
      space = 15
      titleFont = .systemFont(ofSize: 20, weight: .medium)
      imageSize = 25
    case .proMax:
      space = 15
      titleFont = .systemFont(ofSize: 20, weight: .medium)
      imageSize = 25
    }

    titleLabel.font = titleFont

    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),

      imageOfView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -space),
      imageOfView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -space),
      imageOfView.widthAnchor.constraint(equalToConstant: imageSize),
      imageOfView.heightAnchor.constraint(equalToConstant: imageSize)
    ])
  }
}
