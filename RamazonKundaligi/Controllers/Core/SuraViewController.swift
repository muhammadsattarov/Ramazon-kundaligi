


import UIKit

class SuraViewController: UIViewController {

  private let suraHeaderView = SuraHeaderView()
  private let surasView = SurasView()

  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }

  override func viewWillAppear(_ animated: Bool) {
    observeLanguageChanges()
  }

  override func updateUI() {
    super.updateUI()
    suraHeaderView.titleView.titleLabel.text = Bundle.localizedString(forKey: "sura_and_dua")
    surasView.updateUI()
  }
}

// MARK: - Setup Views
private extension SuraViewController {
  func setupViews() {
    view.backgroundColor = .fonGreenColor
    addSubviews()
    setConstraints()
  }
}

// MARK: - Add Subviews
private extension SuraViewController {
  func addSubviews() {
    navigationItem.backButtonTitle = ""
    navigationItem.backBarButtonItem?.tintColor = .white
    view.addSubview(suraHeaderView)
    suraHeaderView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(surasView)
    surasView.translatesAutoresizingMaskIntoConstraints = false
    surasView.suraAndDua = SuraCollectionTitles.mockData()
    surasView.delegate = self
  }
}

// MARK: - Constraints
private extension SuraViewController {
  func setConstraints() {

    let headerViewHeight: CGFloat = windowHeight/2.8
    let space: CGFloat
    
    let screenType = UIView.ScreenSizeType.current()
    switch screenType {

    case .small:
      space = 24
    case .mini:
      space = 28
    case .pro:
      space = 30
    case .proMax:
      space = 30
    }

    NSLayoutConstraint.activate([
      suraHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
      suraHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: space),
      suraHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -space),
      suraHeaderView.heightAnchor.constraint(equalToConstant: headerViewHeight),

      surasView.topAnchor.constraint(equalTo: suraHeaderView.bottomAnchor, constant: -20),
      surasView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: space),
      surasView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -space),
    ])
  }
}

extension SuraViewController: SurasViewDelegate {
  func didSelectItemAt(_ indexPath: IndexPath, title: String) {
    let vc = SuraRowViewController()
    vc.hidesBottomBarWhenPushed = true
    vc.titleLabel.text = Bundle.localizedString(forKey: title)
    vc.configure(with: indexPath)
    navigationController?.pushViewController(vc, animated: true)
  }
}
