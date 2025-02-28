


import UIKit


// MARK: - SettingsTableView
class SettingsTableView: UIView {

  private lazy var tableView: UITableView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.register(SettingsTableViewCell.self,
                forCellReuseIdentifier: SettingsTableViewCell.reuseId)
    $0.register(UITableViewCell.self,
                forCellReuseIdentifier: "cell")
    $0.backgroundColor = .clear
    $0.separatorColor = .white
    $0.separatorStyle = .singleLine
    $0.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
    $0.isScrollEnabled = false
    return $0
  }(UITableView(frame: .zero, style: .insetGrouped))

  let switchControl = UISwitch()
  
  var selectedRegionName: String? {
    didSet {
      UserDefaults.standard.set(selectedRegionName, forKey: "selectedRegion")
      tableView.reloadData()
    }
  }

  func updateSwichControl(isOn: Bool) {
    switchControl.setOn(isOn, animated: true)
    tableView.reloadData()
  }

  private let settingsItems = SettingsItems.mockData()

  weak var delegate: SettingsTableViewDelegate?

  func updateUI() { // Change language in tableview titles
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.tableView.reloadData()
    }
  }

  // 📌 The exact location of the cell where the UISegmentedControl is located
  private func indexPathForLanguageSegment() -> IndexPath? {
      return IndexPath(row: 0, section: 1)
  }

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setConstraints()

    tableView.sectionHeaderHeight = 10
    tableView.sectionFooterHeight = 10
    tableView.estimatedSectionHeaderHeight = 0
    tableView.estimatedSectionFooterHeight = 0
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

// MARK: - Init
private extension SettingsTableView {
  func setup() {
    self.backgroundColor = .clear
    self.layer.cornerRadius = 15
    self.clipsToBounds = true
    self.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
  }

  func setConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: self.topAnchor),
      tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SettingsTableView: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    }
    return settingsItems.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseId, for: indexPath) as? SettingsTableViewCell else {
        return UITableViewCell()
      }

      if ((selectedRegionName?.isEmpty) != nil) || (UserDefaults.standard.string(forKey: "selectedRegion") != nil) {
        cell.titleLabel.text = UserDefaults.standard.string(forKey: "selectedRegion")
      } else {
        cell.titleLabel.text = Bundle.localizedString(forKey: "choose_region")
      }
      
      cell.accessoryView = nil
      return cell
    }

    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.selectionStyle = .none
    cell.accessoryView = nil
    let item = settingsItems[indexPath.row]

    cell.backgroundColor = .cellBackgrountColor
    cell.imageView?.image = UIImage(systemName: item.icon)
    cell.imageView?.tintColor = .goldColor
    let title = Bundle.localizedString(forKey: item.title)
    cell.textLabel?.text = title
    cell.textLabel?.font = .systemFont(ofSize: 16, weight: .regular)
    cell.textLabel?.textColor = .white
    
    if indexPath.section == 1 {
      if indexPath.row == 0 {
        let segmentedControl = UISegmentedControl(items: ["Lotin", "Kril"])
        segmentedControl.addTarget(self, action: #selector(languageChanged(_:)), for: .valueChanged)
        let currentLang = LanguageManager.shared.currentLanguage
        if currentLang == "uz-UZ" {
          segmentedControl.selectedSegmentIndex = 0
        } else {
          segmentedControl.selectedSegmentIndex = 1
        }
        cell.accessoryView = segmentedControl
      } else if indexPath.row == 3 {
        switchControl.addTarget(self, action: #selector(notificationToggled(_:)), for: .valueChanged)
        cell.accessoryView = switchControl
      }
    }

    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

    let height: CGFloat
    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      height = 45
    case .mini:
      height = 48
    case .pro:
      height = 50
    case .proMax:
      height = 50
    }
    if indexPath.section == 0 {
      return height
    }
    return height
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 0 {
      delegate?.didTapSelectLocationName()
    }

    if indexPath.row == 1 {
      shareApp()
    } else if indexPath.row == 2 {
      appEvaluation()
    } else if indexPath.row == 4 {
      aboutApp()
    }
  }
}

// MARK: - Actions
private extension SettingsTableView {
  @objc private func languageChanged(_ sender: UISegmentedControl) {
    delegate?.didTapLanguageChanged(sender)
  }

  @objc private func shareApp() {
    delegate?.didTapShareApp()
  }

  @objc private func appEvaluation() {
    delegate?.didTapAppEvalution()
  }

  @objc private func notificationToggled(_ sender: UISwitch) {
    delegate?.didTapNotification(sender)
  }

  @objc private func aboutApp() {
    delegate?.didTapAboutApp()
  }
}




