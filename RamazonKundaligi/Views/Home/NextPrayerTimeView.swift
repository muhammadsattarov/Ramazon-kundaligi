

import UIKit

class NextPrayerTimeView: UIView {

  lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "Keyingi namoz"
    $0.textAlignment = .center
    $0.textColor = .white
    return $0
  }(UILabel())

  private lazy var timeLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "06:11"
    $0.textAlignment = .center
    $0.textColor = .white
    return $0
  }(UILabel())

  private lazy var prayerTimeNameLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
 //   $0.text = "Bomdod"
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

  func configure(with prayerName: String, prayerTime: String) {
    DispatchQueue.main.async { [weak self] in
      self?.prayerTimeNameLabel.text = Bundle.localizedString(forKey: prayerName)
      self?.timeLabel.text = prayerTime
    }
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

  func setupLabelFonts() {

    let titleLabelFont: UIFont
    let timeLabelFont: UIFont

    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      titleLabelFont = .systemFont(ofSize: 14, weight: .medium)
      timeLabelFont = .systemFont(ofSize: 20, weight: .medium)
    case .mini:
      titleLabelFont = .systemFont(ofSize: 15, weight: .medium)
      timeLabelFont = .systemFont(ofSize: 22, weight: .medium)
    case .pro:
      titleLabelFont = .systemFont(ofSize: 15, weight: .medium)
      timeLabelFont = .systemFont(ofSize: 22, weight: .medium)
    case .proMax:
      titleLabelFont = .systemFont(ofSize: 15, weight: .medium)
      timeLabelFont = .systemFont(ofSize: 22, weight: .medium)
    }
    titleLabel.font = titleLabelFont
    timeLabel.font = timeLabelFont
    prayerTimeNameLabel.font = titleLabelFont
  }

  func setConstraints() {
    NSLayoutConstraint.activate([
      vStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      vStack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}
