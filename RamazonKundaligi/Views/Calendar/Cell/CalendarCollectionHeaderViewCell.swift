

import UIKit

class CalendarCollectionHeaderViewCell: UICollectionViewCell {
  static let reuseId = "CalendarCollectionHeaderViewCell"

  private lazy var iconImage: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleToFill
    $0.tintColor = .goldColor
    return $0
  }(UIImageView())

  private lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 14, weight: .regular)
    $0.textColor = .goldColor
    $0.textAlignment = .center
    return $0
  }(UILabel())

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setConstraints()
  }

  func configure(with model: CalendarHeaderModel) {
    titleLabel.text = Bundle.localizedString(forKey: model.title)
    iconImage.image = UIImage(systemName: model.image)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


// MARK: - Setup UI and Constraints
private extension CalendarCollectionHeaderViewCell {
  func setup() {
    self.backgroundColor = .clear
    
    contentView.addSubview(iconImage)
    contentView.addSubview(titleLabel)
  }

  func setConstraints() {
    NSLayoutConstraint.activate([
      iconImage.widthAnchor.constraint(lessThanOrEqualToConstant: 32),
      iconImage.heightAnchor.constraint(lessThanOrEqualToConstant: 20),
      iconImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      iconImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -5),

      titleLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 5),
      titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
    ])
  }
}
