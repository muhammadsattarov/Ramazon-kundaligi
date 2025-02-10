


import UIKit

class TimeView: UIView {

  private lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 22, weight: .semibold)
    $0.textColor = .goldColor
    $0.textAlignment = .center
    return $0
  }(UILabel())

  private lazy var timeLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 23, weight: .semibold)
    $0.textColor = .white
    $0.textAlignment = .center
    return $0
  }(UILabel())

  private lazy var dateStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.spacing = 3
    return $0
  }(UIStackView(arrangedSubviews: [titleLabel, timeLabel]))


  // MARK: - Init
  init(title: String, date: String) {
    super.init(frame: .zero)
    titleLabel.text = title
    timeLabel.text = date
    self.backgroundColor = .cellBackgrountColor
    self.layer.cornerRadius = 15
    self.layer.masksToBounds = true
    setup()
    setConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

// MARK: - Init
private extension TimeView {
  func setup() {
    self.addSubview(dateStack)
  }

  func setConstraints() {
    NSLayoutConstraint.activate([
      dateStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      dateStack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}
