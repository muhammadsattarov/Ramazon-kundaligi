

import UIKit

class NextPrayerTimeView: UIView {

  private lazy var titleLabel = UILabel(
    text: "Keyingi namoz",
    font: .systemFont(ofSize: 15, weight: .medium),
    textAlignment: .center
  )
  private lazy var timeLabel = UILabel(
    text: "06:11",
    font: .systemFont(ofSize: 22, weight: .medium),
    textAlignment: .center
  )
  private lazy var prayerTimeNameLabel = UILabel(
    text: "Bomdod",
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
private extension NextPrayerTimeView {
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
