

import UIKit

class HomeTableHeaderView: UIView {

  private lazy var headerImage: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.image = UIImage(named: "home_header")
    $0.contentMode = .scaleAspectFit
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  private lazy var bottomImage: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.image = UIImage(named: "home_bottom")
    $0.contentMode = .scaleToFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.textColor = .goldColor
    $0.textAlignment = .center
    return $0
  }(UILabel())

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

  private let refreshButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setImage(UIImage(systemName: "arrow.triangle.2.circlepath"), for: .normal)
    $0.tintColor = .white
    return $0
  }(UIButton(type: .system))

  var didTapRefreshButton: (() -> Void)?

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .clear
    setup()
    setConstraints()
  }
  
  func configure(with locationName: String) {
    DispatchQueue.main.async { [weak self] in
      self?.locationNameLabel.text = locationName
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension HomeTableHeaderView {
  func setup() {
    self.addSubview(headerImage)
    self.addSubview(bottomImage)
    self.addSubview(titleLabel)
    self.addSubview(locationStack)
    self.addSubview(refreshButton)

    refreshButton.addTarget(
      self,
      action: #selector(refreshButtonTapped),
      for: .touchUpInside
    )
  }

  func setConstraints() {
    let titleLabelFont: UIFont
    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      titleLabelFont = .systemFont(ofSize: 26, weight: .semibold)
    case .mini:
      titleLabelFont = .systemFont(ofSize: 30, weight: .semibold)
    case .pro:
      titleLabelFont = .systemFont(ofSize: 30, weight: .semibold)
    case .proMax:
      titleLabelFont = .systemFont(ofSize: 30, weight: .semibold)
    }

    titleLabel.font = titleLabelFont

    let space: CGFloat = 20
    let topSpace: CGFloat = windowHeight/7.8
    NSLayoutConstraint.activate([
      headerImage.topAnchor.constraint(equalTo: self.topAnchor, constant: -15),
      headerImage.leftAnchor.constraint(equalTo: self.leftAnchor),
      headerImage.widthAnchor.constraint(equalToConstant: windowWidth),
      headerImage.heightAnchor.constraint(equalToConstant: windowHeight/3.4),

      bottomImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      bottomImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: space),
      bottomImage.widthAnchor.constraint(equalToConstant: windowWidth - (space*2)),
      bottomImage.heightAnchor.constraint(equalToConstant: windowHeight/6.5),

      titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topSpace),
      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

      locationStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
      locationStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),

      refreshButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -35),
      refreshButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
      refreshButton.widthAnchor.constraint(equalToConstant: 25),
      refreshButton.heightAnchor.constraint(equalToConstant: 23),
    ])
  }

  @objc func refreshButtonTapped() {
    didTapRefreshButton?()
    refreshButton.rotate360Degrees()
  }
}



