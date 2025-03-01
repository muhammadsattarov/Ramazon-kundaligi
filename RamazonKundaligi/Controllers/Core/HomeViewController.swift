
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

  private var blurView: UIVisualEffectView?
  private var spinner: UIActivityIndicatorView?

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
    addActions()
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
    print("Home", #function)
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

// MARK: - Actions
private extension HomeViewController {
  func addActions() {
    headerView.didTapRefreshButton = { [weak self] in
      guard let self = self else { return }
      self.handleRefresh()
    }
  }

  func handleRefresh() {
    showSpinnerAndBlur()

    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
      guard let self = self else { return }
      self.hideSpinnerAndBlur()
      self.fetchDataFromBatabase() // Typo tuzatildi
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

// MARK: - Blur effect
private extension HomeViewController {
  func showSpinnerAndBlur() {
    // Blur efekt yaratish
    let blurEffect = UIBlurEffect(style: .light)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.alpha = 0.0 // Boshlanishda ko‘rinmas bo‘lsin
    blurView.frame = view.bounds
    blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(blurView)
    self.blurView = blurView

    // Spinner yaratish
    let spinner = UIActivityIndicatorView(style: .medium)
    spinner.center = view.center
    spinner.alpha = 0.0 // Boshlanishda ko‘rinmas bo‘lsin
    view.addSubview(spinner)
    self.spinner = spinner

    // Animatsiya bilan paydo bo‘lish
    UIView.animate(withDuration: 0.3, animations: {
      blurView.alpha = 0.5
      spinner.alpha = 1.0
    }) { _ in
      spinner.startAnimating()
    }
  }

  func hideSpinnerAndBlur() {
    UIView.animate(withDuration: 0.3, animations: {
      self.blurView?.alpha = 0.0
      self.spinner?.alpha = 0.0
    }) { _ in
      self.blurView?.removeFromSuperview()
      self.spinner?.stopAnimating()
      self.spinner?.removeFromSuperview()
    }
  }
}
