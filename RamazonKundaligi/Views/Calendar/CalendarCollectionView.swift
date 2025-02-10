


import UIKit

class CalendarHeaderCollectionView: UIView {

  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.register(CalendarCollectionHeaderViewCell.self,
                        forCellWithReuseIdentifier: CalendarCollectionHeaderViewCell.reuseId)
    collection.translatesAutoresizingMaskIntoConstraints = false
    collection.backgroundColor = .clear
    return collection
  }()

  let headerData = CalendarHeaderModel.mockData()

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .clear
    setup()
    setConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


// MARK: - Setup UI and Constraints
private extension CalendarHeaderCollectionView {
  func setup() {
    self.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.dataSource = self
  }

  func setConstraints() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: self.topAnchor),
      collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
      collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])
  }
}

extension CalendarHeaderCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return headerData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionHeaderViewCell.reuseId, for: indexPath) as? CalendarCollectionHeaderViewCell else {
        return UICollectionViewCell()
      }
      cell.configure(with: headerData[indexPath.item])
      return cell
  }
}

extension CalendarHeaderCollectionView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let headerItemWidth: CGFloat = (collectionView.frame.width) / 4
      return CGSize(width: headerItemWidth,
                    height: 80)
  }
}






enum CalendarCollectionType: Int {
  case header
  case footer
}

struct CalendarModel {
  let daynumber: Int
  let dayName: String
  let saharTime: String
  let iftarTime: String

  static func mockData() -> [CalendarModel] {
    return [
      .init(daynumber: 1, dayName: "2-mart", saharTime: "06:12", iftarTime: "18:21"),
      .init(daynumber: 2, dayName: "3-mart", saharTime: "06:15", iftarTime: "18:24"),
      .init(daynumber: 3, dayName: "4-mart", saharTime: "06:17", iftarTime: "18:26"),
      .init(daynumber: 4, dayName: "5-mart", saharTime: "06:18", iftarTime: "18:28"),
      .init(daynumber: 5, dayName: "6-mart", saharTime: "06:20", iftarTime: "18:29"),
      .init(daynumber: 6, dayName: "7-mart", saharTime: "06:22", iftarTime: "18:31"),
      .init(daynumber: 7, dayName: "8-mart", saharTime: "06:23", iftarTime: "18:35"),
      .init(daynumber: 8, dayName: "9-mart", saharTime: "06:25", iftarTime: "18:36"),
      .init(daynumber: 9, dayName: "10-mart", saharTime: "06:27", iftarTime: "18:38"),
      .init(daynumber: 10, dayName: "11-mart", saharTime: "06:29", iftarTime: "18:39"),
      .init(daynumber: 11, dayName: "12-mart", saharTime: "06:31", iftarTime: "18:41"),
      .init(daynumber: 12, dayName: "13-mart", saharTime: "06:34", iftarTime: "18:42"),
    ]
  }
}

struct CalendarHeaderModel {
  let title: String
  let image: String

  static func mockData() -> [CalendarHeaderModel] {
    return [
      .init(title: "Ramazon", image: "moon"),
      .init(title: "Sana", image: "calendar"),
      .init(title: "Saharlik", image: "moon.haze"),
      .init(title: "Iftorlik", image: "sunset")
    ]
  }
}
