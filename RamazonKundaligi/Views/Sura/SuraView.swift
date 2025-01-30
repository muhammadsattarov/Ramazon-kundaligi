

import UIKit

class SurasView: UIView {

  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10
    layout.sectionInset = .init(top: 30, left: 10, bottom: 0, right: 10)
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.register(SuraCollectionViewCell.self,
                        forCellWithReuseIdentifier: SuraCollectionViewCell.reuseId)
    collection.backgroundColor = .midnightGreenColor
    collection.translatesAutoresizingMaskIntoConstraints = false
    collection.layer.cornerRadius = 15
    collection.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    collection.bounces = false
    return collection
  }()

  var suraAndDua: [SuraCollectionTitles] = []

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - Init
private extension SurasView {
  func setup() {
    self.backgroundColor = .clear
    self.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.dataSource = self
  }

  func setConstraints() {
    
    let cellHeight: CGFloat = windowHeight/6.5 // get a collectionViewCell height
    let collectionHeight: CGFloat = (cellHeight*3) + 60 // calculate collectionView height

    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: self.topAnchor),
      collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: collectionHeight),
      collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])
  }
}

extension SurasView: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return suraAndDua.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuraCollectionViewCell.reuseId, for: indexPath) as! SuraCollectionViewCell
    cell.configure(with: suraAndDua[indexPath.row])
    return cell
  }
}

extension SurasView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (collectionView.frame.width-30)/2,
                  height: windowHeight/6.5)
  }
}
