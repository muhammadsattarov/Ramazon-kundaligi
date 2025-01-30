

import UIKit

class SuraCollectionViewCell: UICollectionViewCell {
  static let reuseId = "SuraCollectionViewCell"
  
  private lazy var titleLabel = UILabel(
    text: "Suralar",
    font: .systemFont(ofSize: 22, weight: .medium),
    textColor: .goldColor,
    textAlignment: .center,
    numberOfLines: 2
  )

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
    titleLabel.text = model.title
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
    let space: CGFloat = 20
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),

      imageOfView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -space),
      imageOfView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -space),
      imageOfView.widthAnchor.constraint(equalToConstant: 25),
      imageOfView.heightAnchor.constraint(equalToConstant: 25)
    ])
  }
}
