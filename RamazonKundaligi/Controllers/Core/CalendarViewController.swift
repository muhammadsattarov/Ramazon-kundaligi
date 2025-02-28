

import UIKit

class CalendarViewController: UIViewController {

  private let calendarHeaderView = CalendarHeaderView()
  private let calendarCollectionView = CalendarHeaderCollectionView()
  private let calendarTableView = CalendarTableView()

  private var districtID: Int {
    let savedID = UserDefaults.standard.integer(forKey: Constants.districtID)
    return savedID != 0 ? savedID : 24
  }

  private let viewModel = TimesViewModel()

  private var ramadanSchedule: RamazonTaqvim? {
    didSet {
      updateCurrentData()
    }
  }

  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }

  override func viewWillAppear(_ animated: Bool) {
    observeLanguageChanges()
    fetchDataFromBackend()
    isShowAlert()
  }

  // MARK: - Localizatsion
  override func updateUI() {
    super.updateUI()
    calendarHeaderView.titleLabel.text = Bundle.localizedString(forKey: "ramadan_schedule")
    calendarHeaderView.todayLabel.text = Bundle.localizedString(forKey: "today_title")
    viewModel.getGregorianAndHijriDate { [weak self] gregoryan, hijriy in
      guard let self = self else { return }
      self.calendarHeaderView.configure(hijriy, gregorian: gregoryan)
    }
    calendarHeaderView.saharlikView.configure(
      with: Bundle.localizedString(forKey: "saharlik"),
      time: "-:-"
    )
    calendarHeaderView.iftorlikView.configure(
      with: Bundle.localizedString(forKey: "iftorlik"),
      time: "-:-"
    )
    calendarCollectionView.updateUI()
  }
}

// MARK: - Setup Views
private extension CalendarViewController {
  func setupViews() {
    view.backgroundColor = .fonGreenColor
    addSubviews()
    setConstraints()
//    fetchDataFromBackend()
  }
}

// MARK: - Add Subviews
private extension CalendarViewController {
  func fetchDataFromBackend() {
    RamadanService.shared.fetchRamadanSchedule(districtID) { [weak self] taqvim in
      guard let self = self else { return }
      if let taqvim {
        DispatchQueue.main.async {
          self.ramadanSchedule = taqvim
          self.calendarTableView.configure(with: taqvim)
        }
      }
    }
  }

  func updateCurrentData() {
    print(#function)
    guard let currentDay = getCurrentPrayerTimes() else { return }
    guard let region = ramadanSchedule else { return }
    print("\(region.region), \(region.district)")
    calendarHeaderView.locationNameLabel.text = "\(region.region), \(region.district)"
    calendarHeaderView.saharlikView.configure(with: "saharlik", time: currentDay.saharlik)
    calendarHeaderView.iftorlikView.configure(with: "iftorlik", time: currentDay.iftorlik)
  }

  func getCurrentPrayerTimes() -> (saharlik: String, iftorlik: String)? {
    let formatter = DateFormatter()
    formatter.dateFormat = "d-MMMM"
    formatter.locale = Locale(identifier: "uz_UZ")

   // let currentDate = formatter.string(from: Date())
    let currentDate = "1-Mart"
    print(currentDate)
    if let prayerTime = ramadanSchedule?.times.first(where: { $0.date_time.lowercased() == currentDate.lowercased() }) {
      return (prayerTime.saharlik, prayerTime.iftorlik)
    }
    return nil
  }

  func isShowAlert() {
    let didShowAlert = UserDefaults.standard.bool(forKey: Constants.didShowAlert)

    if !didShowAlert {
      showAlert()
      UserDefaults.standard.set(true, forKey: Constants.didShowAlert) // Alert shows once
    }
  }

  func showAlert() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.showCustomAlert(
        title: "Taqvimda biroz farq bo'lishi mumkin. Shu sababdan taqvimdagi saharlik(og'iz yopish) vaqtidan 5-10 daqiqa oldin og'iz yopish tavsiya qilinadi. Iftorlik(og'iz ochish) vaqtida esa shom kirganiga ishonch hosil qilib og'iz ochish tavsiya etiladi.",
        showCancelButton: false,
        buttonTitle: "Tushinarli") {
          print("Tushinarli")
        }
    }
  }
}

// MARK: - Add Subviews
private extension CalendarViewController {
  func addSubviews() {
    view.addSubview(calendarHeaderView)
    view.addSubview(calendarCollectionView)
    view.addSubview(calendarTableView)
    calendarHeaderView.translatesAutoresizingMaskIntoConstraints = false
    calendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
    calendarTableView.translatesAutoresizingMaskIntoConstraints = false
  }
}

// MARK: - Constraints
private extension CalendarViewController {
  func setConstraints() {
    let space: CGFloat = 20
    let bottomSpace: CGFloat
    let calendarCollectionViewHeight: CGFloat

    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      calendarCollectionViewHeight = 74
      bottomSpace = 15
    case .mini:
      calendarCollectionViewHeight = 80
      bottomSpace = 20
    case .pro:
      calendarCollectionViewHeight = 80
      bottomSpace = 20
    case .proMax:
      calendarCollectionViewHeight = 80
      bottomSpace = 20
    }

    NSLayoutConstraint.activate([
      calendarHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
      calendarHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor),
      calendarHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor),

      calendarCollectionView.topAnchor.constraint(equalTo: calendarHeaderView.bottomAnchor),
      calendarCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: space),
      calendarCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -space),
      calendarCollectionView.heightAnchor.constraint(equalToConstant: calendarCollectionViewHeight),

      calendarTableView.topAnchor.constraint(equalTo: calendarCollectionView.bottomAnchor),
      calendarTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: space),
      calendarTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -space),
      calendarTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -bottomSpace)
    ])
  }
}
