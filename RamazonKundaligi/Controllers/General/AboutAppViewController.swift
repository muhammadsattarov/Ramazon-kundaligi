

import UIKit

class AboutAppViewController: UIViewController {

  private let scrollView: UIScrollView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.alwaysBounceVertical = true
    return $0
  }(UIScrollView())

  private lazy var containerStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.spacing = 5
    return $0
  }(UIStackView())

  private let spaceView: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .clear
    $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
    return $0
  }(UIView())

  private let secondSpaceView: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .clear
    $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
    return $0
  }(UIView())

  private let backButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .heavy)
    $0.setImage(UIImage(systemName: "arrow.left", withConfiguration: config), for: .normal)
    $0.backgroundColor = .cellBackgrountColor
    $0.layer.cornerRadius = 17.5
    $0.clipsToBounds = true
    $0.tintColor = .white
    return $0
  }(UIButton(type: .system))

  private let versionView = SettingsHeaderVersionView(isLarge: true)
  private let aboutAppTextView = AboutAppTextView()
  private let privacyPolicyView = SupportView(title: Bundle.localizedString(forKey: "Mahfiylik siyosati"), icon: "hand.raised")
  private let supportView = SupportView(title: Bundle.localizedString(forKey: "support"), icon: "location")
  private let messengersView = MessengersView()

  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
    observeLanguageChanges()
  }

  override func updateUI() {
    versionView.titleLabel.text = Bundle.localizedString(forKey: "ramadan_schedule")
    versionView.versionLabel.text = Bundle.localizedString(forKey: "interpretation_title")
    aboutAppTextView.textLabel.text = Bundle.localizedString(forKey: "support_description")
    messengersView.titleLabel.text = Bundle.localizedString(forKey: "name_in_uzb")
  }
}


// MARK: - Setup Views
private extension AboutAppViewController {
  func setupViews() {
    view.backgroundColor = .fonGreenColor
    addSubviews()
    setConstraints()
    addActions()
  }
}

// MARK: - Setup Views
private extension AboutAppViewController {
  func addSubviews() {
    view.addSubview(scrollView)
    scrollView.addSubview(containerStack)
    containerStack.addArrangedSubview(spaceView)
    containerStack.addArrangedSubview(versionView)
    containerStack.addArrangedSubview(aboutAppTextView)
    containerStack.addArrangedSubview(privacyPolicyView)
    containerStack.addArrangedSubview(supportView)
    containerStack.addArrangedSubview(messengersView)
    containerStack.addArrangedSubview(secondSpaceView)

    view.addSubview(backButton)

    messengersView.delegate = self
    versionView.translatesAutoresizingMaskIntoConstraints = false
    aboutAppTextView.translatesAutoresizingMaskIntoConstraints = false
    messengersView.translatesAutoresizingMaskIntoConstraints = false
    messengersView.heightAnchor.constraint(equalToConstant: 100).isActive = true
  }
}

// MARK: - Setup Views
private extension AboutAppViewController {
  func setConstraints() {
    let cancelTopSpace: CGFloat
    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      cancelTopSpace = 35
    case .mini:
      cancelTopSpace = 75
    case .pro:
      cancelTopSpace = 80
    case .proMax:
      cancelTopSpace = 80
    }

    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
      scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      containerStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
      containerStack.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor),
      containerStack.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor),
      containerStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
      containerStack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

      backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
      backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: cancelTopSpace),
      backButton.widthAnchor.constraint(equalToConstant: 35),
      backButton.heightAnchor.constraint(equalToConstant: 35),
    ])
  }
}

// MARK: - Actions
private extension AboutAppViewController {
  func addActions() {
    backButton.addTarget(
      self,
      action: #selector(didTapBackButton),
      for: .touchUpInside
    )
    let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPrivacyPolicy))
    privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
    let supportGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSupport))
    supportView.addGestureRecognizer(supportGesture)
  }

  @objc func didTapPrivacyPolicy() {
    let vc = PrivacyPolicyViewController()
    guard let url = URL(string: Constants.privacyPolicy) else {
      print("Invalid url")
      return
    }
    vc.configure(url)
    present(vc, animated: true)
  }

  @objc func didTapSupport() {
    showActionSheet()
  }

  @objc func didTapBackButton() {
    navigationController?.popViewController(animated: true)
  }
}

extension AboutAppViewController: MessengersViewProtocol {
  func telegramIconTapped() {
    customAlert(text: Bundle.localizedString(forKey: "support_alert_title"))
  }
  
  func instaIconTapped() {
    openSocialMedia(urlString: Constants.instaUrl)
  }
  
}

// MARK: - Custom alert and ActionSheet
extension AboutAppViewController {
  func showActionSheet() {
    let alert = UIAlertController(
      title: Bundle.localizedString(forKey: "support"),
      message: nil,
      preferredStyle: .actionSheet
    )
    alert.addAction(UIAlertAction(title: Bundle.localizedString(forKey: "insta_direct"),
                                  style: .default, handler: { _ in
      self.openSocialMedia(urlString: Constants.instaUrl)
    }))
    alert.addAction(UIAlertAction(title: Bundle.localizedString(forKey: "Yopish"),
                                  style: .cancel))
    present(alert, animated: true)
  }

  func openSocialMedia(urlString: String) {
      if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
  }
}




