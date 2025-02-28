


import UIKit

class SuraRowViewController: UIViewController {

  private lazy var backButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)
    $0.setImage(UIImage(systemName: "arrow.left", withConfiguration: config), for: .normal)
    $0.tintColor = .black
    $0.backgroundColor = .white
    $0.layer.cornerRadius = 17.5
    $0.clipsToBounds = true
    return $0
  }(UIButton(type: .system))

  private let headerImage: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.image = UIImage(named: "home_header")
    $0.contentMode = .scaleAspectFit
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  let titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
  //  $0.font = .systemFont(ofSize: 25, weight: .semibold)
    $0.textColor = .goldColor
    $0.textAlignment = .center
    $0.numberOfLines = 2
    return $0
  }(UILabel())

  private let tableView: UITableView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.register(SurasRowTableViewCell.self,
                forCellReuseIdentifier: SurasRowTableViewCell.reuseId)
    $0.separatorStyle = .none
    $0.backgroundColor = .clear
    return $0
  }(UITableView(frame: .zero, style: .plain))

  var indexPath: IndexPath? {
    didSet {
      setupData()
    }
  }

  private let viewModel = SurasViewModel()

  var data: [Dua] = []

  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }

  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: false)
   // observeLanguageChanges()
  }

  override func updateUI() {

  }

  func configure(with indexPath: IndexPath) {
    self.indexPath = indexPath
  }
}

// MARK: - Setup Views
private extension SuraRowViewController {
  func setupViews() {
    view.backgroundColor = .fonGreenColor
    addSubviews()
    setConstraints()
    addActions()
  }
}

// MARK: - Add Subviews
private extension SuraRowViewController {
  func addSubviews() {
    view.addSubview(headerImage)
    view.addSubview(backButton)
    view.addSubview(titleLabel)
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
  }
}


// MARK: - Constraints
private extension SuraRowViewController {
  func setupData() {
    guard let indexPath = indexPath else {
        print("indexPath is nil")
        return
    }
    if indexPath.row == viewModel.mockData2[indexPath.row].id {
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        self.data = viewModel.mockData2[indexPath.row].dua
        self.tableView.reloadData()
      }
    }
  }

}

// MARK: - Constraints
private extension SuraRowViewController {
  func addActions() {
    backButton.addTarget(
      self,
      action: #selector(didTapBackButton),
      for: .touchUpInside
    )
  }

  @objc func didTapBackButton() {
    navigationController?.popViewController(animated: true)
  }
}

// MARK: - Constraints
private extension SuraRowViewController {
  func setConstraints() {

    let imageSize: CGFloat
    let titleFont: UIFont
    let buttonTopSpace: CGFloat
    let tableViewSpace: CGFloat

    let screenType = UIView.ScreenSizeType.current()
    switch screenType {

    case .small:
      imageSize = windowHeight/3.4
      titleFont = .systemFont(ofSize: 25, weight: .semibold)
      tableViewSpace = windowHeight / 5.1
      buttonTopSpace = 40
    case .mini:
      imageSize = windowHeight/3.4
      titleFont = .systemFont(ofSize: 25, weight: .semibold)
      tableViewSpace = windowHeight / 5.1
      buttonTopSpace = 65
    case .pro:
      imageSize = windowHeight/3.4
      titleFont = .systemFont(ofSize: 25, weight: .semibold)
      tableViewSpace = windowHeight / 5.1
      buttonTopSpace = 70
    case .proMax:
      imageSize = windowHeight/3.8
      titleFont = .systemFont(ofSize: 25, weight: .semibold)
      tableViewSpace = windowHeight / 5.1
      buttonTopSpace = 70
    }

    titleLabel.font = titleFont

    NSLayoutConstraint.activate([
      backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: buttonTopSpace),
      backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
      backButton.widthAnchor.constraint(equalToConstant: 35),
      backButton.heightAnchor.constraint(equalToConstant: 35),

      headerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -15),
      headerImage.leftAnchor.constraint(equalTo: view.leftAnchor),
      headerImage.rightAnchor.constraint(equalTo: view.rightAnchor),
      headerImage.heightAnchor.constraint(equalToConstant: imageSize),

      titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: tableViewSpace-(tableViewSpace/2.2)),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: tableViewSpace),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SuraRowViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SurasRowTableViewCell.reuseId, for: indexPath) as? SurasRowTableViewCell else {
      return UITableViewCell()
    }
    cell.configure(with: data[indexPath.row])
    return cell
  }
}
