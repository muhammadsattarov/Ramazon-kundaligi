


import UIKit
import StoreKit

class SettingsViewController: UIViewController {

private let settingsHeaderView = SettingsHeaderView()
private let settingsTableView = SettingsTableView()

  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }

  override func viewWillAppear(_ animated: Bool) {
    UIView.animate(withDuration: 0.3) { [weak self] in
      guard let self = self else { return }
      self.observeLanguageChanges()
    }
  }

  override func updateUI() {
    super.updateUI()
    settingsHeaderView.titleLabel.text = Bundle.localizedString(forKey: "settings_title")
    settingsHeaderView.versionView.titleLabel.text = Bundle.localizedString(forKey: "ramadan_schedule")
    settingsHeaderView.versionView.versionLabel.text = "\(Bundle.localizedString(forKey: "interpretation_title")) 1.0.0"
    settingsTableView.updateUI()
  }
}

// MARK: - Setup Views
private extension SettingsViewController {
  func setupViews() {
    navigationItem.backButtonTitle = ""
    view.backgroundColor = .fonGreenColor
    addSubviews()
    setConstraints()
    settingsTableView.updateSwichControl(isOn: NotificationManager.shared.isNotificationsEnabled)
  }
}

// MARK: - Add Subviews
private extension SettingsViewController {
  func addSubviews() {
    view.addSubview(settingsHeaderView)
    view.addSubview(settingsTableView)
    settingsHeaderView.translatesAutoresizingMaskIntoConstraints = false
    settingsTableView.translatesAutoresizingMaskIntoConstraints = false
    settingsTableView.delegate = self
  }
}

// MARK: - Constraints
private extension SettingsViewController {
  func setConstraints() {
    let tableViewSize: CGFloat
    let topSpace: CGFloat
    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      tableViewSize =  330
      topSpace = -30
    case .mini:
      tableViewSize = 350
      topSpace = -10
    case .pro:
      topSpace = -10
      tableViewSize = 370
    case .proMax:
      topSpace = -10
      tableViewSize = 370
    }

    NSLayoutConstraint.activate([
      settingsHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
      settingsHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor),
      settingsHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor),
      settingsHeaderView.heightAnchor.constraint(equalToConstant: windowHeight/2.2),

      settingsTableView.topAnchor.constraint(equalTo: settingsHeaderView.bottomAnchor, constant: topSpace),
      settingsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      settingsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
      settingsTableView.heightAnchor.constraint(equalToConstant: tableViewSize)
    ])
  }
}

extension SettingsViewController: SettingsTableViewDelegate {
  func didTapSelectLocationName() {
    let pickerVC = RegionPickerViewController()
    pickerVC.modalPresentationStyle = .custom
    pickerVC.transitioningDelegate = self
    pickerVC.onSelect = { [weak self] selectedRegion, selectedDistrict in
      self?.settingsTableView.selectedRegionName = "\(selectedRegion), \(selectedDistrict)"
    }
    present(pickerVC, animated: true)
  }
  
  func didTapLanguageChanged(_ sender: UISegmentedControl) { // Change app language with SegmentedControl
    changeLanguage(to: sender.selectedSegmentIndex == 0 ? "uz-UZ" : "uz-Cyrl-UZ")


  }

  func didTapShareApp() {
    guard let appStoreURL = URL(string: "https://apps.apple.com/app/id6742691277") else { return }
    let activityViewController = UIActivityViewController(activityItems: [appStoreURL], applicationActivities: nil)
    present(activityViewController, animated: true)
  }
  
  func didTapAppEvalution() {
    requestAppReview()
  }
  
  func didTapNotification(_ sender: UISwitch) {
    NotificationManager.shared.isNotificationsEnabled = sender.isOn
  }
  
  func didTapAboutApp() {
    let vc = AboutAppViewController()
    vc.hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension SettingsViewController {
  func changeLanguage(to language: String) {
      LanguageManager.shared.currentLanguage = language
  }
}

extension SettingsViewController: UIViewControllerTransitioningDelegate {
      func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
          return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
      }

  // 📌 6️⃣ UIPickerView ni ekranning yarmigacha ochish uchun custom modal
  class HalfSizePresentationController: UIPresentationController {
      override var frameOfPresentedViewInContainerView: CGRect {
          guard let containerView = containerView else { return .zero }
          let height = containerView.bounds.height / 2 // 📌 Ekranning yarmi
          return CGRect(x: 0,
                        y: containerView.bounds.height - height,
                        width: containerView.bounds.width,
                        height: height)
      }
  }
}

extension SettingsViewController {
  func requestAppReview() {
      if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
          SKStoreReviewController.requestReview(in: scene)
      }
  }
}

