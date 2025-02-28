

import UIKit

class HomeView: UIView {

  private let tableView: UITableView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.register(HomeTableViewCell.self,
                forCellReuseIdentifier: HomeTableViewCell.reuseId)
    $0.backgroundColor = .clear
    $0.separatorColor = .white
    $0.separatorStyle = .singleLine
    $0.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
    $0.bounces = false
    $0.isScrollEnabled = false
    return $0
  }(UITableView(frame: .zero, style: .insetGrouped))

  var prayerTimes: [PrayerTimesModel] = [] {
    didSet {
      tableView.reloadData()
    }
  }

  func updateUI() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.tableView.reloadData()
    }
  }

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setupTableView()
    setConstraints()
  }

  func configure(with model: [PrayerTimesModel]) {
    DispatchQueue.main.async { [weak self] in
      self?.prayerTimes = model
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension HomeView {
  func setup() {
    self.backgroundColor = .clear
    self.addSubview(tableView)
  }

  func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }
}

private extension HomeView {
  func setConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: self.topAnchor),
      tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])
  }
}


extension HomeView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return prayerTimes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseId, for: indexPath) as! HomeTableViewCell
    cell.selectionStyle = .none
    cell.configure(with: prayerTimes[indexPath.row])
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      return 44
    case .mini:
      return 48
    case .pro:
      return 50
    case .proMax:
      return 50
    }
  }
}
