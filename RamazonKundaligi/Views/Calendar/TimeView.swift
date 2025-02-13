


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
    setupLabelFonts()
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

  func setupLabelFonts() {

    let titleLabelFont: UIFont
    let timeLabelFont: UIFont

    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      titleLabelFont = .systemFont(ofSize: 19, weight: .semibold)
      timeLabelFont = .systemFont(ofSize: 20, weight: .semibold)
    case .medium:
      titleLabelFont = .systemFont(ofSize: 21, weight: .semibold)
      timeLabelFont = .systemFont(ofSize: 22, weight: .semibold)
    case .large:
      titleLabelFont = .systemFont(ofSize: 22, weight: .semibold)
      timeLabelFont = .systemFont(ofSize: 23, weight: .semibold)
    }
    titleLabel.font = titleLabelFont
    timeLabel.font = timeLabelFont
  }

  func setConstraints() {
    NSLayoutConstraint.activate([
      dateStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      dateStack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}
