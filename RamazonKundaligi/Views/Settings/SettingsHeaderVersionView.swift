


import UIKit

class SettingsHeaderVersionView: UIView {

  private lazy var iconImage: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.image = UIImage(named: "logo")
    $0.contentMode = .scaleToFill
    $0.backgroundColor = .fonWhiteColor
    $0.layer.masksToBounds = true
    return $0
  }(UIImageView())

  lazy var titleLabel = UILabel(
    text: "Ramazon taqvimi",
    font: .systemFont(ofSize: 18, weight: .medium),
    textColor: .white,
    textAlignment: .center
  )

  lazy var versionLabel: UILabel = {
    $0.text = "Talqin 1.0.0"
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.textColor = .fonWhiteColor
    $0.textAlignment = .center
    return $0
  }(UILabel())

  private lazy var vStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    return $0
  }(UIStackView(arrangedSubviews: [titleLabel, versionLabel]))

  // MARK: - Init
  init(isLarge: Bool) {
    super.init(frame: .zero)
    setup()
    setConstraints()

    let imageSize: CGFloat
    
    if isLarge {
      imageSize = windowWidth/4
      iconImage.layer.cornerRadius = 20
      vStack.spacing = 10
      titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
      versionLabel.font = .systemFont(ofSize: 17, weight: .medium)
    } else {
      imageSize = 55
      iconImage.layer.cornerRadius = 10
      vStack.spacing = 5
      titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
      versionLabel.font = .systemFont(ofSize: 15, weight: .medium)
    }

    iconImage.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
    iconImage.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
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
    NSLayoutConstraint.activate([
      iconImage.topAnchor.constraint(equalTo: self.topAnchor),
      iconImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),

      vStack.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 10),
      vStack.leftAnchor.constraint(equalTo: self.leftAnchor),
      vStack.rightAnchor.constraint(equalTo: self.rightAnchor),
      vStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
    ])
  }
}

