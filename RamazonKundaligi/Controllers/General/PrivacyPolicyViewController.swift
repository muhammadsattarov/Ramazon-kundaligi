
import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {

  private let headerView: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    return $0
  }(UIView())

  private let backButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .heavy)
    $0.setImage(UIImage(systemName: "xmark", withConfiguration: config), for: .normal)
    $0.tintColor = .black
    return $0
  }(UIButton(type: .system))

  let webView: WKWebView = {
    let webConfiguration = WKWebViewConfiguration()
    webConfiguration.processPool = WKProcessPool()
    let webView = WKWebView(frame: .zero, configuration: webConfiguration)
    webView.translatesAutoresizingMaskIntoConstraints = false
    return webView
  }()

  private(set) var urlString: URL? {
    didSet {
      updateWebView()
    }
  }

  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }

  func configure(_ url: URL) {
    self.urlString = url
  }
}

// MARK: - Setup Views
private extension PrivacyPolicyViewController {
  func setupViews() {
    view.backgroundColor = .white
    view.addSubview(headerView)
    headerView.addSubview(backButton)
    view.addSubview(webView)
    setConstraints()
    addActions()
  }

  func updateWebView() {
    DispatchQueue.main.async { [weak self] in
      if let url = self?.urlString {
        self?.webView.load(URLRequest(url: url))
      }
    }
  }
}

// MARK: - Cosntraints
private extension PrivacyPolicyViewController {
  func setConstraints() {
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.topAnchor),
      headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
      headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 60),

      backButton.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 20),
      backButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
      backButton.widthAnchor.constraint(equalToConstant: 30),
      backButton.heightAnchor.constraint(equalToConstant: 30),

      webView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
      webView.leftAnchor.constraint(equalTo: view.leftAnchor),
      webView.rightAnchor.constraint(equalTo: view.rightAnchor),
      webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

}


// MARK: - Actions
private extension PrivacyPolicyViewController {
  func addActions() {
    backButton.addTarget(
      self,
      action: #selector(didTapBackButton),
      for: .touchUpInside
    )
  }

  @objc func didTapBackButton() {
    dismiss(animated: true)
  }
}

