

import UIKit

class SuraHeaderTitleView: UIView {

  lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.textColor = .goldColor
    $0.textAlignment = .center
    return $0
  }(UILabel())

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setupLabelFonts() 
    setConstraints()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.backgroundColor = .fonGreenColor
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


// MARK: - Init
private extension SuraHeaderTitleView {
  func setup() {
    self.addSubview(titleLabel)
  }

  func setupLabelFonts() {
    let titleFont: UIFont

    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      titleFont = .systemFont(ofSize: 24, weight: .semibold)
    case .mini:
      titleFont = .systemFont(ofSize: 26, weight: .semibold)
    case .pro:
      titleFont = .systemFont(ofSize: 26, weight: .semibold)
    case .proMax:
      titleFont = .systemFont(ofSize: 26, weight: .semibold)
    }
  titleLabel.font = titleFont
  }

  func setConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    ])
  }
}
