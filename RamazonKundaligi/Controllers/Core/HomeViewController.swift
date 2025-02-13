
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

  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
}

// MARK: - Setup Views
private extension HomeViewController {
  func setupViews() {
    view.backgroundColor = .fonGreenColor
    addSubviews()
    setConstraints()
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
    homeView.prayerTimes = PrayerTimesModel.mockData()
  }
}

// MARK: - Constraints
private extension HomeViewController {
  func setConstraints() {
    let headerSpace: CGFloat
    let tableSpace: CGFloat
    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      headerSpace = 15
      tableSpace = -18
    case .medium:
      headerSpace = 18
      tableSpace = -15
    case .large:
      headerSpace = 20
      tableSpace = -12
    }

    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.topAnchor),
      headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
      headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
      headerView.heightAnchor.constraint(equalToConstant: windowHeight/2.80),

      homeHeaderStack.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: headerSpace),
      homeHeaderStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
      homeHeaderStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
      homeHeaderStack.heightAnchor.constraint(equalToConstant: windowHeight/9.5),

      homeView.topAnchor.constraint(equalTo: homeHeaderStack.bottomAnchor, constant: tableSpace),
      homeView.leftAnchor.constraint(equalTo: view.leftAnchor),
      homeView.rightAnchor.constraint(equalTo: view.rightAnchor),
      homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}


struct PrayerTimesModel {
  let title: String
  let time: String
  let image: String

  static func mockData() -> [PrayerTimesModel] {
    let prayerTimes: [PrayerTimesModel] = [
      .init(title: "Bomdod", time: "06:21", image: "sunrise"),
      .init(title: "Quyosh chiqishi", time: "07:43", image: "sun.max"),
      .init(title: "Peshin", time: "12:19", image: "sun.max.fill"),
      .init(title: "Asr", time: "15:14", image: "sunset"),
      .init(title: "Shom", time: "16:57", image: "moon.haze"),
      .init(title: "Hufton", time: "18:21", image: "moon.stars")
    ]
    return prayerTimes
  }
}
