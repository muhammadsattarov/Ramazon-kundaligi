


import UIKit

class SuraHeaderView: UIView {

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
  }

  func setConstraints() {
    let imageHeight: CGFloat = windowHeight/6.5

    NSLayoutConstraint.activate([
      imageOfView.leftAnchor.constraint(equalTo: self.leftAnchor),
      imageOfView.rightAnchor.constraint(equalTo: self.rightAnchor),
      imageOfView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      imageOfView.heightAnchor.constraint(equalToConstant: imageHeight),
    ])
  }
}
