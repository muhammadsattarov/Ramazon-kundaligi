

import UIKit

class TodayDateHeaderView: UIView {

  private lazy var titleLabel = UILabel(
    text: "Bugun",
    font: .systemFont(ofSize: 15, weight: .medium),
    textAlignment: .center
  )
  private lazy var timeLabel = UILabel(
    text: "01, Ramazon 1444",
    font: .systemFont(ofSize: 15, weight: .medium),
    textAlignment: .center
  )
  private lazy var prayerTimeNameLabel = UILabel(
    text: "24 Mart, 2025",
    font: .systemFont(ofSize: 15, weight: .medium),
    textAlignment: .center
  )

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

  func setConstraints() {
    NSLayoutConstraint.activate([
      vStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      vStack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}
