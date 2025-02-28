

import UIKit

class SettingsHeaderView: UIView {

  private lazy var headerImage: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.image = UIImage(named: "settings_header")
    $0.contentMode = .scaleToFill
    return $0
  }(UIImageView())

  lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.textColor = .goldColor
    $0.textAlignment = .center
  return $0
  }(UILabel())

  let versionView = SettingsHeaderVersionView()

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
private extension SettingsHeaderView {
  func setup() {
    self.backgroundColor = .clear
    self.addSubview(headerImage)
    self.addSubview(titleLabel)
    self.addSubview(versionView)
    versionView.translatesAutoresizingMaskIntoConstraints = false
  }

  func setConstraints() {

    let titleFont: UIFont

    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      titleFont = .systemFont(ofSize: 28, weight: .semibold)
    case .mini:
      titleFont = .systemFont(ofSize: 30, weight: .semibold)
    case .pro:
      titleFont = .systemFont(ofSize: 32, weight: .semibold)
    case .proMax:
      titleFont = .systemFont(ofSize: 32, weight: .semibold)
    }
    titleLabel.font = titleFont

    NSLayoutConstraint.activate([
      headerImage.topAnchor.constraint(equalTo: self.topAnchor),
      headerImage.leftAnchor.constraint(equalTo: self.leftAnchor),
      headerImage.rightAnchor.constraint(equalTo: self.rightAnchor),
      headerImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),

      versionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
      versionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      versionView.widthAnchor.constraint(equalToConstant: windowWidth/2),

      titleLabel.bottomAnchor.constraint(equalTo: versionView.topAnchor, constant: -30),
      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
    ])
  }
}
