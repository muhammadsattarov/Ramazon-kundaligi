

import UIKit

class TodayDateHeaderView: UIView {

  lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
 //   $0.text = "Bugun"
    $0.textAlignment = .center
    $0.textColor = .white
    return $0
  }(UILabel())

  private lazy var hijriDateLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "hijri: -/-"
    $0.textAlignment = .center
    $0.textColor = .white
    return $0
  }(UILabel())

  private lazy var gregorianDateLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "gregoryan: -/-"
    $0.textAlignment = .center
    $0.textColor = .white
    return $0
  }(UILabel())

  private lazy var vStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.spacing = 3
    return $0
  }(UIStackView(arrangedSubviews: [titleLabel, hijriDateLabel, gregorianDateLabel]))

// MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setupLabelFonts()
    setConstraints()
  }

  func configure(_ gregorian: String, hijri: String) {
    DispatchQueue.main.async { [weak self] in
      self?.gregorianDateLabel.text = gregorian
      self?.hijriDateLabel.text = hijri
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup and Constraints
private extension TodayDateHeaderView {
  func setup() {
    self.layer.cornerRadius = 15
    self.layer.masksToBounds = true
    self.backgroundColor = .cellBackgrountColor
    self.addSubview(vStack)
  }

  func setupLabelFonts() {

    let titleLabelFont: UIFont

    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      titleLabelFont = .systemFont(ofSize: 14, weight: .medium)
    case .mini:
      titleLabelFont = .systemFont(ofSize: 15, weight: .medium)
    case .pro:
      titleLabelFont = .systemFont(ofSize: 15, weight: .medium)
    case .proMax:
      titleLabelFont = .systemFont(ofSize: 15, weight: .medium)
    }
    titleLabel.font = titleLabelFont
    hijriDateLabel.font = titleLabelFont
    gregorianDateLabel.font = titleLabelFont
  }

  func setConstraints() {
    NSLayoutConstraint.activate([
      vStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      vStack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}
