


import UIKit

class SettingsHeaderVersionView: UIView {

  private lazy var iconImage: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.image = UIImage(named: "settings_icon")
    $0.contentMode = .scaleToFill
    $0.backgroundColor = .fonWhiteColor
    $0.layer.cornerRadius = 10
    $0.layer.masksToBounds = true
    return $0
  }(UIImageView())

  private lazy var titleLabel = UILabel(
    text: "Ramazon taqvimi",
    font: .systemFont(ofSize: 18, weight: .medium),
    textColor: .white,
    textAlignment: .center
  )

  private lazy var versionLabel = UILabel(
    text: "Talqin 1.0.0",
    font: .systemFont(ofSize: 15, weight: .medium),
    textColor: .fonWhiteColor,
    textAlignment: .center
  )

  private lazy var vStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.spacing = 5
    $0.distribution = .fillProportionally
    return $0
  }(UIStackView(arrangedSubviews: [titleLabel, versionLabel]))

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

// MARK: - Init
private extension SettingsHeaderVersionView {
  func setup() {
    self.backgroundColor = .clear
    self.addSubview(vStack)
    self.addSubview(iconImage)
  }

  func setConstraints() {

    let imageSize: CGFloat

    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      imageSize = 52
    case .medium:
      imageSize = 55
    case .large:
      imageSize = 55
    }

    NSLayoutConstraint.activate([
      iconImage.widthAnchor.constraint(equalToConstant: imageSize),
      iconImage.heightAnchor.constraint(equalToConstant: imageSize),
      iconImage.topAnchor.constraint(equalTo: self.topAnchor),
      iconImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),

      vStack.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 10),
      vStack.leftAnchor.constraint(equalTo: self.leftAnchor),
      vStack.rightAnchor.constraint(equalTo: self.rightAnchor),
      vStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
}

