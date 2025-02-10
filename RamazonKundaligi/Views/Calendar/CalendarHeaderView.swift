

import UIKit

class CalendarHeaderView: UIView {

  private lazy var topImage: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.image = UIImage(named: "calendar_top")
    $0.contentMode = .scaleToFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  private lazy var titleLabel = UILabel(
    text: "Namoz Vaqtlari",
    font: .systemFont(ofSize: 25, weight: .semibold),
    textColor: .goldColor,
    textAlignment: .center
  )

  private lazy var locatonImage: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.image = UIImage(systemName: "location.fill")
    $0.contentMode = .scaleToFill
    $0.tintColor = .goldColor
    return $0
  }(UIImageView())

  private lazy var locationNameLabel = UILabel(
    text: "Sayxunobod, Sirdaryo, Uzbekistan",
    font: .systemFont(ofSize: 15, weight: .medium),
    textColor: .white,
    textAlignment: .center
  )

  private lazy var locationStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.spacing = 3
    return $0
  }(UIStackView(arrangedSubviews: [locatonImage, locationNameLabel]))


  private lazy var todayLabel = UILabel(
    text: "Bugun:",
    font: .systemFont(ofSize: 15, weight: .medium),
    textColor: .goldColor,
    textAlignment: .center
  )

  private lazy var todayDateLabel = UILabel(
    text: "01, Ramazon, 1444-24, Mart, 2025",
    font: .systemFont(ofSize: 15, weight: .medium),
    textColor: .white,
    textAlignment: .center
  )

  private lazy var todayDateStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.spacing = 3
    return $0
  }(UIStackView(arrangedSubviews: [todayLabel, todayDateLabel]))

  private let saharlikView = TimeView(title: "Saharlik", date: "04:23")
  private let iftorlikView = TimeView(title: "Iftorlik", date: "18:27")

  private lazy var iftorlikSaharlikStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.spacing = 20
    $0.distribution = .fillEqually
    return $0
  }(UIStackView(arrangedSubviews: [saharlikView, iftorlikView]))

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .clear
    setup()
    setConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

// MARK: - Init
private extension CalendarHeaderView {
  func setup() {
    self.addSubview(topImage)
    self.addSubview(titleLabel)
    self.addSubview(locationStack)
    self.addSubview(todayDateStack)
    self.addSubview(iftorlikSaharlikStack)
  }

  func setConstraints() {
    NSLayoutConstraint.activate([
      topImage.topAnchor.constraint(equalTo: self.topAnchor),
      topImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
      topImage.widthAnchor.constraint(equalToConstant: 95),
      topImage.heightAnchor.constraint(equalToConstant: 200),

      titleLabel.topAnchor.constraint(equalTo: topImage.centerYAnchor),
      titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),

      locationStack.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
      locationStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),

      todayDateStack.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 20),
      todayDateStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),

      iftorlikSaharlikStack.topAnchor.constraint(equalTo: todayDateStack.bottomAnchor, constant: 10),
      iftorlikSaharlikStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
      iftorlikSaharlikStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
      iftorlikSaharlikStack.heightAnchor.constraint(equalToConstant: 70),
      iftorlikSaharlikStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
}
