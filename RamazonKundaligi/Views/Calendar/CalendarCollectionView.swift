

import UIKit

class CalendarHeaderCollectionView: UIView {

  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    layout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.register(CalendarCollectionHeaderViewCell.self,
                        forCellWithReuseIdentifier: CalendarCollectionHeaderViewCell.reuseId)
    collection.translatesAutoresizingMaskIntoConstraints = false
    collection.backgroundColor = .clear
    return collection
  }()

  let headerData = CalendarHeaderModel.mockData()

  func updateUI() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.collectionView.reloadData()
    }
  }

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
      let headerItemWidth: CGFloat = (collectionView.frame.width-20) / 4
    let itemHeight: CGFloat

    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      itemHeight = 74
    case .mini:
      itemHeight = 80
    case .pro:
      itemHeight = 80
    case .proMax:
      itemHeight = 80
    }
      return CGSize(width: headerItemWidth,
                    height: itemHeight)
  }
}

