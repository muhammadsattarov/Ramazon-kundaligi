


import UIKit

class SettingsViewController: UIViewController {

private let settingsHeaderView = SettingsHeaderView()
private let settingsTableView = SettingsTableView()

  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
}

// MARK: - Setup Views
private extension SettingsViewController {
  func setupViews() {
    view.backgroundColor = .fonGreenColor
    addSubviews()
    setConstraints()
  }
}

// MARK: - Add Subviews
private extension SettingsViewController {
  func addSubviews() {
    view.addSubview(settingsHeaderView)
    view.addSubview(settingsTableView)
    settingsHeaderView.translatesAutoresizingMaskIntoConstraints = false
    settingsTableView.translatesAutoresizingMaskIntoConstraints = false
  }
}

// MARK: - Constraints
private extension SettingsViewController {
  func setConstraints() {
    let tableViewSize: CGFloat
    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      tableViewSize =  269
    case .medium:
      tableViewSize = 287
    case .large:
      tableViewSize = 299
    }

    NSLayoutConstraint.activate([
      settingsHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
      settingsHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor),
      settingsHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor),
      settingsHeaderView.heightAnchor.constraint(equalToConstant: windowHeight/2.2),

      settingsTableView.topAnchor.constraint(equalTo: settingsHeaderView.bottomAnchor, constant: 15),
      settingsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
      settingsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
      settingsTableView.heightAnchor.constraint(equalToConstant: tableViewSize)
    ])
  }
}
