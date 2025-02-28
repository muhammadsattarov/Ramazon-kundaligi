

import UIKit

class CalendarHeaderView: UIView {

  private lazy var topImage: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.image = UIImage(named: "calendar_top")
    $0.contentMode = .scaleToFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "Ramazon taqvimi"
    $0.textColor = .goldColor
    $0.numberOfLines = 2
    $0.textAlignment = .center
  return $0
  }(UILabel())

  private lazy var locatonImage: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.image = UIImage(systemName: "location.fill")
    $0.contentMode = .scaleAspectFit
    $0.tintColor = .goldColor
    return $0
  }(UIImageView())

  lazy var locationNameLabel: UILabel = {
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.textColor = .white
    $0.textAlignment = .left
    $0.numberOfLines = 2
    return $0
  }(UILabel())

  private lazy var locationStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.spacing = 3
    return $0
  }(UIStackView(arrangedSubviews: [locatonImage, locationNameLabel]))

  lazy var todayLabel: UILabel = {
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.textColor = .goldColor
    $0.textAlignment = .center
    return $0
  }(UILabel())

  lazy var todayDateLabel: UILabel = {
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.textColor = .white
    $0.textAlignment = .center
    return $0
  }(UILabel())

  private lazy var todayDateStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.spacing = 3
    return $0
  }(UIStackView(arrangedSubviews: [todayLabel, todayDateLabel]))

  let saharlikView = TimeView()
  let iftorlikView = TimeView()

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

  func configure(_ hijri: String, gregorian: String) {
    todayDateLabel.text = "\(hijri) / \(gregorian)"
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

    let labelFont: UIFont
    let space: CGFloat = 20
    let topImageSize: CGFloat
    let iftorlikSaharlikStackFont: CGFloat

    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      labelFont = .systemFont(ofSize: 25, weight: .semibold)
      topImageSize = 170
      iftorlikSaharlikStackFont = 65
    case .mini:
      labelFont = .systemFont(ofSize: 28, weight: .semibold)
      topImageSize = 200
      iftorlikSaharlikStackFont = 70
    case .pro:
      labelFont = .systemFont(ofSize: 28, weight: .semibold)
      topImageSize = 200
      iftorlikSaharlikStackFont = 70
    case .proMax:
      labelFont = .systemFont(ofSize: 28, weight: .semibold)
      topImageSize = 200
      iftorlikSaharlikStackFont = 70
    }
    titleLabel.font = labelFont

    NSLayoutConstraint.activate([
      topImage.topAnchor.constraint(equalTo: self.topAnchor),
      topImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -space),
      topImage.widthAnchor.constraint(equalToConstant: topImageSize/2),
      topImage.heightAnchor.constraint(equalToConstant: topImageSize),

      titleLabel.topAnchor.constraint(equalTo: topImage.centerYAnchor),
      titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: space),

      locationStack.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
      locationStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
      locationStack.rightAnchor.constraint(equalTo: topImage.leftAnchor, constant: 30),

      todayDateStack.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: space),
      todayDateStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),

      iftorlikSaharlikStack.topAnchor.constraint(equalTo: todayDateStack.bottomAnchor, constant: 10),
      iftorlikSaharlikStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: space),
      iftorlikSaharlikStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -space),
      iftorlikSaharlikStack.heightAnchor.constraint(equalToConstant: iftorlikSaharlikStackFont),
      iftorlikSaharlikStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
}
