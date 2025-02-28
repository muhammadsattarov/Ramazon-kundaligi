
import UIKit

class HomeViewController: UIViewController {

  private let headerView = HomeTableHeaderView()
  private let nextPrayerTimeView = NextPrayerTimeView()
  private let todayDateHeaderView = TodayDateHeaderView()
  private let homeView = HomeView()

  private lazy var homeHeaderStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.spacing = 20
    $0.distribution = .fillEqually
    return $0
  }(UIStackView(arrangedSubviews: [nextPrayerTimeView, todayDateHeaderView]))

  private let viewModel = TimesViewModel()

  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }

  override func viewWillAppear(_ animated: Bool) {
    fetchDataFromBatabase()
    observeLanguageChanges()
  }

  override func updateUI() {
    super.updateUI()
    headerView.titleLabel.text = Bundle.localizedString(forKey: "namoz_vaqtlari")
    nextPrayerTimeView.titleLabel.text = Bundle.localizedString(forKey: "next_prayer_time")
    todayDateHeaderView.titleLabel.text = Bundle.localizedString(forKey: "today_title")
    homeView.updateUI()
  }
}

// MARK: - Setup Views
private extension HomeViewController {
  func setupViews() {
    view.backgroundColor = .fonGreenColor
    addSubviews()
    setConstraints()
    updateCurrentDate()
  }
}

// MARK: - Add Subviews
private extension HomeViewController {
  func addSubviews() {
    view.addSubview(headerView)
    headerView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(homeHeaderStack)
    view.addSubview(homeView)
    homeView.translatesAutoresizingMaskIntoConstraints = false
  }
}

// MARK: - Add Subviews
private extension HomeViewController {
  func fetchDataFromBatabase() {
    print(#function)
    viewModel.showPrayerTimes { [weak self] nextPrayerName, nextPrayerTime, locationName in
      guard let self = self else { return }
      self.nextPrayerTimeView.configure(with: nextPrayerName, prayerTime: nextPrayerTime)
      self.headerView.configure(with: locationName)
      self.homeView.configure(with: viewModel.prayerTimes)
    }
  }

  func updateCurrentDate() {
    viewModel.getGregorianAndHijriDate { [weak self] gregorian, hijri in
      self?.todayDateHeaderView.configure(gregorian, hijri: hijri)
    }
  }
}

// MARK: - Constraints
private extension HomeViewController {
  func setConstraints() {

    let headerViewSize: CGFloat
    let headerStackHeight: CGFloat
    let headerSpace: CGFloat
    let tableSpace: CGFloat

    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      headerViewSize = windowHeight/2.80
      headerStackHeight = windowHeight/9.5
      headerSpace = 15
      tableSpace = -18
    case .mini:
      headerViewSize = windowHeight/2.80
      headerStackHeight = windowHeight/9.5
      headerSpace = 18
      tableSpace = -15
    case .pro:
      headerViewSize = windowHeight/2.70
      headerStackHeight = windowHeight/9.5
      headerSpace = 20
      tableSpace = -12
    case .proMax:
      headerViewSize = windowHeight/2.60
      headerStackHeight = windowHeight/9
      headerSpace = 20
      tableSpace = -12
    }

    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.topAnchor),
      headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
      headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
      headerView.heightAnchor.constraint(equalToConstant: headerViewSize),

      homeHeaderStack.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: headerSpace),
      homeHeaderStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
      homeHeaderStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
      homeHeaderStack.heightAnchor.constraint(equalToConstant: headerStackHeight),

      homeView.topAnchor.constraint(equalTo: homeHeaderStack.bottomAnchor, constant: tableSpace),
      homeView.leftAnchor.constraint(equalTo: view.leftAnchor),
      homeView.rightAnchor.constraint(equalTo: view.rightAnchor),
      homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}
