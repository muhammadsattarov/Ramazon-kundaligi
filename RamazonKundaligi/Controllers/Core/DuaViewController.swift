


import UIKit

class DuaViewController: UIViewController {

  let titleView = SuraHeaderTitleView()

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
  }

  override func updateUI() {
    super.updateUI()
    titleView.titleLabel.text = Bundle.localizedString(forKey: "dua_title")
    self.tableView.reloadData()
  }
}

// MARK: - Setup Views
private extension DuaViewController {
  func setupViews() {
    view.backgroundColor = .fonGreenColor
    addSubviews()
    setupTableView()
    setConstraints()
  }
}

// MARK: - Add Subviews
private extension DuaViewController {
  func addSubviews() {
    navigationItem.backButtonTitle = ""
    navigationItem.backBarButtonItem?.tintColor = .white

    titleView.translatesAutoresizingMaskIntoConstraints = false

    tableView.delegate = self
    tableView.dataSource = self
  }

  func setupTableView() {
    view.addSubview(titleView)
    view.addSubview(tableView)

    tableView.tableFooterView = UIView(frame: CGRect(
      x: 0,
      y: 0,
      width: windowWidth,
      height: 20)
    )
  }
}

// MARK: - Constraints
private extension DuaViewController {
  func setConstraints() {
    NSLayoutConstraint.activate([
      titleView.topAnchor.constraint(equalTo: view.topAnchor),
      titleView.leftAnchor.constraint(equalTo: view.leftAnchor),
      titleView.rightAnchor.constraint(equalTo: view.rightAnchor),
      titleView.heightAnchor.constraint(equalToConstant: windowHeight/9),

      tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
