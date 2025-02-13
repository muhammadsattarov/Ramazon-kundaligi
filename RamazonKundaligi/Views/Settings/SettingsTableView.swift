


import UIKit

class SettingsTableView: UIView {

  private lazy var tableView: UITableView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.register(UITableViewCell.self,
                forCellReuseIdentifier: "cell")
    $0.backgroundColor = .clear
    $0.separatorColor = .white
    $0.separatorStyle = .singleLine
    $0.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
    $0.isScrollEnabled = false
    return $0
  }(UITableView())

  private let settingsItems = SettingsItems.mockData()

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setConstraints()
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
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return settingsItems.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.selectionStyle = .none

    let item = settingsItems[indexPath.row]

    cell.backgroundColor = .cellBackgrountColor
    cell.imageView?.image = UIImage(systemName: item.icon)
    cell.imageView?.tintColor = .goldColor
    cell.textLabel?.text = item.title
    cell.textLabel?.textColor = .white

    if indexPath.row == 0 {
      let segmentedControl = UISegmentedControl(items: ["Kir", "Lot"])
      segmentedControl.selectedSegmentIndex = 0
      segmentedControl.addTarget(self, action: #selector(languageChanged(_:)), for: .valueChanged)
      cell.accessoryView = segmentedControl
    }

    if indexPath.row == 4 {
      let switchControl = UISwitch()
      switchControl.isOn = false
      switchControl.addTarget(self, action: #selector(darkModeToggled(_:)), for: .valueChanged)
      cell.accessoryView = switchControl
    }

    if indexPath.row == 5 {
      let switchControl = UISwitch()
      switchControl.isOn = false
      switchControl.addTarget(self, action: #selector(notificationToggled(_:)), for: .valueChanged)
      cell.accessoryView = switchControl
    }

    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      return 45
    case .medium:
      return 48
    case .large:
      return 50
    }
  }
}

// MARK: - Actions
private extension SettingsTableView {
  @objc private func languageChanged(_ sender: UISegmentedControl) {
        let selectedLanguage = sender.selectedSegmentIndex == 0 ? "Kiril" : "Lotin"
        print("Til o'zgartirildi: \(selectedLanguage)")
    }

    @objc private func darkModeToggled(_ sender: UISwitch) {
        print("Tungi rejim: \(sender.isOn ? "ON" : "OFF")")
    }

    @objc private func notificationToggled(_ sender: UISwitch) {
        print("Bildirishnoma: \(sender.isOn ? "ON" : "OFF")")
    }
}




