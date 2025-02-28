


import UIKit

class DuaViewController: UIViewController {

  private let suraHeaderView = SuraHeaderView()
  let titleView = SuraHeaderTitleView()

  private let fonView: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .midnightGreenColor
    return $0
  }(UIView())

  private let tableView: UITableView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.register(DuasRowTableViewCell.self,
                forCellReuseIdentifier: DuasRowTableViewCell.reuseId)
    $0.separatorStyle = .none
    $0.backgroundColor = .clear
    return $0
  }(UITableView(frame: .zero, style: .plain))

  var data = Dua.mockData()

  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }

  override func viewWillAppear(_ animated: Bool) {
    observeLanguageChanges()
    observeLanguageChanges()
  }

  override func updateUI() {
    super.updateUI()
    titleView.titleLabel.text = "Duolar"
    self.tableView.reloadData()
  }
}

// MARK: - Setup Views
private extension DuaViewController {
  func setupViews() {
    view.backgroundColor = .fonGreenColor
    addSubviews()
    setConstraints()
  }
}

// MARK: - Add Subviews
private extension DuaViewController {
  func addSubviews() {
    navigationItem.backButtonTitle = ""
    navigationItem.backBarButtonItem?.tintColor = .white
    view.addSubview(suraHeaderView)
    view.addSubview(titleView)
    view.addSubview(fonView)
    view.addSubview(tableView)

    titleView.translatesAutoresizingMaskIntoConstraints = false
    suraHeaderView.translatesAutoresizingMaskIntoConstraints = false

    tableView.delegate = self
    tableView.dataSource = self
  }
}

// MARK: - Constraints
private extension DuaViewController {
  func setConstraints() {

    let headerViewHeight: CGFloat = windowHeight/2.8
    let space: CGFloat
    let topSpace: CGFloat
    let headerViewSize: CGFloat

    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      space = 15
      headerViewSize = 40
      topSpace = windowHeight/11
    case .mini:
      space = 20
      headerViewSize = 45
      topSpace = windowHeight/11
    case .pro:
      space = 20
      headerViewSize = 45
      topSpace = windowHeight/11
    case .proMax:
      space = 20
      headerViewSize = 45
      topSpace = windowHeight/11
    }

    NSLayoutConstraint.activate([
      suraHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
      suraHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: space),
      suraHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -space),
      suraHeaderView.heightAnchor.constraint(equalToConstant: headerViewHeight),

      titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: topSpace),
      titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      titleView.widthAnchor.constraint(equalToConstant: windowWidth/2.5),
      titleView.heightAnchor.constraint(equalToConstant: headerViewSize),
      
      fonView.topAnchor.constraint(equalTo: suraHeaderView.bottomAnchor, constant: -20),
      fonView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: space),
      fonView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -space),
      fonView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 30),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: space),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -space),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension DuaViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: DuasRowTableViewCell.reuseId, for: indexPath) as? DuasRowTableViewCell else {
      return UITableViewCell()
    }
    cell.configure(with: data[indexPath.row])
    return cell
  }
}
