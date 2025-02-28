

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
    $0.spacing = 10
    return $0
  }(UIStackView())

  private let spaceView: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .clear
    $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
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
  private let supportView = SupportView()
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
    navigationItem.title = Bundle.localizedString(forKey: "about_app")
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
    containerStack.addArrangedSubview(supportView)
    containerStack.addArrangedSubview(messengersView)

    view.addSubview(backButton)

    messengersView.delegate = self
    versionView.translatesAutoresizingMaskIntoConstraints = false
    aboutAppTextView.translatesAutoresizingMaskIntoConstraints = false
    supportView.translatesAutoresizingMaskIntoConstraints = false
    messengersView.translatesAutoresizingMaskIntoConstraints = false
    messengersView.heightAnchor.constraint(equalToConstant: 100).isActive = true
  }
}

// MARK: - Setup Views
private extension AboutAppViewController {
  func setConstraints() {
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
      backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
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

    let supportGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSupport))
    supportView.addGestureRecognizer(supportGesture)
  }

  @objc func didTapSupport() {
    print(#function)
  }

  @objc func didTapBackButton() {
    navigationController?.popViewController(animated: true)
  }
}

extension AboutAppViewController: MessengersViewProtocol {
  func telegramIconTapped() {
    print(#function)
  }
  
  func instaIconTapped() {
    print(#function)
  }
  

}
