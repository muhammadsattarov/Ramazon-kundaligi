


import UIKit

class CalendarTableView: UIView {

  private let tableView: UITableView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.register(CalendarTableViewCell.self,
                forCellReuseIdentifier: CalendarTableViewCell.reuseId)
    $0.separatorStyle = .none
    $0.backgroundColor = .clear
    $0.showsVerticalScrollIndicator = false
    $0.bounces = false
    return $0
  }(UITableView())

  private var calendarData: RamazonTaqvim?
  private var currentDay: CurrentDay?

  var isToday: Bool?

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setConstraints()
  }

  func configure<T>(with model: T) {
      DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }

          if let calendarModel = model as? RamazonTaqvim {
              self.calendarData = calendarModel
          } else if let prayerModel = model as? CurrentDay {
              self.currentDay = prayerModel
          }
          self.tableView.reloadData()
      }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

// MARK: - Init
private extension CalendarTableView {
  func setup() {
    self.backgroundColor = .clear
    self.layer.cornerRadius = 12
    self.layer.masksToBounds = true
    self.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
  }

  func setConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: self.topAnchor),
      tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])
  }
}

extension CalendarTableView: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let calendarData {
        return calendarData.times.count
  }
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarTableViewCell.reuseId, for: indexPath) as? CalendarTableViewCell else {
      return UITableViewCell()
    }
    cell.selectionStyle = .none
    guard let data = calendarData?.times[indexPath.row] else { return UITableViewCell() }
    guard let ramadanCount = RamazonTaqvim.ramadanCount?[indexPath.row] else { return UITableViewCell() }
    cell.configure(with: ramadanCount,
                   model: data)
    if data.saharlik == currentDay?.saharlik {
      cell.isToday = true
    } else {
      cell.isToday = false
    }
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard let data = calendarData?.times[indexPath.row] else { return 50 }
    if data.saharlik == currentDay?.saharlik {
      return 60
    }
    return 50
  }
}
