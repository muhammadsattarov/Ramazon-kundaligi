


import UIKit

class OnboardingViewController: UIViewController {

  private lazy var imageOfView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.image = UIImage(named: "onboarding")
    $0.contentMode = .scaleToFill
    return $0
  }(UIImageView())

  private lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "Ramazon \nMuborak!!!"
    $0.textColor = .goldColor
    $0.textAlignment = .center
    $0.numberOfLines = 2
    return $0
  }(UILabel())

  private lazy var nextButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    $0.setTitle("Davom etish", for: .normal)
    $0.setTitleColor(.fonGreenColor, for: .normal)
    $0.backgroundColor = .goldColor
    $0.layer.cornerRadius = 22.5
    $0.layer.masksToBounds = true
    return $0
  }(UIButton(type: .system))

  // MARK: - Init
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
}

private extension OnboardingViewController {
  func setupViews() {
    view.backgroundColor = .fonGreenColor
    addSubviews()
    setConstraints()
    addActions()
  }
}

private extension OnboardingViewController {
  func addSubviews() {
    view.addSubview(imageOfView)
    view.addSubview(titleLabel)
    view.addSubview(nextButton)
  }
}

private extension OnboardingViewController {
  func addActions() {
    nextButton.addTarget(
      self,
      action: #selector(didTapNextButton),
      for: .touchUpInside
    )
  }

  @objc func didTapNextButton() {
    let vc = MainTabBarController()
    vc.modalPresentationStyle = .overFullScreen
    vc.modalTransitionStyle = .crossDissolve
    present(vc, animated: true)
  }
}

private extension OnboardingViewController {
  func setConstraints() {

    let imageSize: CGFloat
    let space: CGFloat
    let labelFont: UIFont

    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      imageSize = windowWidth
      space = 35
      labelFont = .systemFont(ofSize: 35, weight: .bold)
    case .mini:
      imageSize = windowWidth
      space = 45
      labelFont = .systemFont(ofSize: 38, weight: .bold)
    case .pro:
      imageSize = windowWidth
      space = 50
      labelFont = .systemFont(ofSize: 40, weight: .bold)
    case .proMax:
      imageSize = windowWidth
      space = 50
      labelFont = .systemFont(ofSize: 40, weight: .bold)
    }
    titleLabel.font = labelFont


    NSLayoutConstraint.activate([
      imageOfView.topAnchor.constraint(equalTo: view.topAnchor),
      imageOfView.leftAnchor.constraint(equalTo: view.leftAnchor),
      imageOfView.widthAnchor.constraint(equalToConstant: imageSize),
      imageOfView.heightAnchor.constraint(equalToConstant: imageSize),

      titleLabel.topAnchor.constraint(equalTo: imageOfView.bottomAnchor, constant: space),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      nextButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: space),
      nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      nextButton.heightAnchor.constraint(equalToConstant: 45),
      nextButton.widthAnchor.constraint(equalToConstant: windowWidth/1.3)
    ])
  }
}

