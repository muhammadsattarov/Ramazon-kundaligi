
import UIKit

class LaunchScreenViewController: UIViewController {

  // MARK: - Properties
  private var switchTask: DispatchWorkItem?

  private lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 30, weight: .black)
    $0.text = "Ramazon Kundaligi"
    $0.textColor = .white
    $0.textAlignment = .center
    return $0
  }(UILabel())


  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // After 2 seconds we will make the transition
    switchTask = DispatchWorkItem { [weak self] in
        self?.switchToMainViewController()
    }

    if let task = switchTask {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: task)
    }
  }
}

// MARK: - Setup Views
private extension LaunchScreenViewController {
 func setupViews() {
   view.backgroundColor = .fonGreenColor
   addSubviews()
   setContraints()
 }
}

// MARK: - Add Subviews
private extension LaunchScreenViewController {
 func addSubviews() {
   view.addSubview(titleLabel)
 }
}


// MARK: - Constrains
private extension LaunchScreenViewController {

  func switchToMainViewController() {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first else { return }

    let homeVC = MainTabBarController()

    window.rootViewController = homeVC
    UIView.transition(
      with: window,
      duration: 0.5,
      options: .transitionCrossDissolve,
      animations: nil,
      completion: nil
    )
  }
}

// MARK: - Constrains
private extension LaunchScreenViewController {
 func setContraints() {
   NSLayoutConstraint.activate([
    titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
   ])
 }
}

