

import UIKit

class TodayDateHeaderView: UIView {

  private lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "Bugun"
    $0.textAlignment = .center
    $0.textColor = .white
    return $0
  }(UILabel())

  private lazy var timeLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "01, Ramazon 1444"
    $0.textAlignment = .center
    $0.textColor = .white
    return $0
  }(UILabel())

  private lazy var prayerTimeNameLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "24 Mart, 2025"
    $0.textAlignment = .center
    $0.textColor = .white
    return $0
  }(UILabel())

  private lazy var vStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.spacing = 3
    return $0
  }(UIStackView(arrangedSubviews: [titleLabel, timeLabel, prayerTimeNameLabel]))

// MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setupLabelFonts()
    setConstraints()
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
    case .medium:
      titleLabelFont = .systemFont(ofSize: 15, weight: .medium)
    case .large:
      titleLabelFont = .systemFont(ofSize: 15, weight: .medium)
    }
    titleLabel.font = titleLabelFont
    timeLabel.font = titleLabelFont
    prayerTimeNameLabel.font = titleLabelFont
  }

  func setConstraints() {
    NSLayoutConstraint.activate([
      vStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      vStack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}
