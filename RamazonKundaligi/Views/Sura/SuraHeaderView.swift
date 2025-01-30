//
//  SuraHeaderView.swift
//  RamazonKundaligi
//
//  Created by user on 29/01/25.
//

import UIKit

class SuraHeaderView: UIView {
static let reuseId = "SuraHeaderView"
  
  private let titleView = SuraHeaderTitleView()

  private lazy var imageOfView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.image = UIImage(named: "home_bottom")
    $0.contentMode = .scaleToFill
    return $0
  }(UIImageView())

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
private extension SuraHeaderView {
  func setup() {
    self.backgroundColor = .fonGreenColor
    self.addSubview(imageOfView)
    self.addSubview(titleView)
    titleView.translatesAutoresizingMaskIntoConstraints = false
  }

  func setConstraints() {
    let topSpace: CGFloat = windowHeight/8.5
    let imageHeight: CGFloat = windowHeight/6.5
    NSLayoutConstraint.activate([
      imageOfView.leftAnchor.constraint(equalTo: self.leftAnchor),
      imageOfView.rightAnchor.constraint(equalTo: self.rightAnchor),
      imageOfView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      imageOfView.heightAnchor.constraint(equalToConstant: imageHeight),

      titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: topSpace),
      titleView.leftAnchor.constraint(equalTo: self.leftAnchor),
      titleView.rightAnchor.constraint(equalTo: self.rightAnchor),
      titleView.heightAnchor.constraint(equalToConstant: 60),
    ])
  }
}
