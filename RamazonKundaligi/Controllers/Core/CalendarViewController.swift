

import UIKit

class CalendarViewController: UIViewController {

  private let calendarHeaderView = CalendarHeaderView()
  private let calendarCollectionView = CalendarHeaderCollectionView()
  private let calendarTableView = CalendarTableView()

  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
}

// MARK: - Setup Views
private extension CalendarViewController {
  func setupViews() {
    view.backgroundColor = .fonGreenColor
    addSubviews()
    setConstraints()
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
    case .medium:
      calendarCollectionViewHeight = 80
      bottomSpace = 20
    case .large:
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
