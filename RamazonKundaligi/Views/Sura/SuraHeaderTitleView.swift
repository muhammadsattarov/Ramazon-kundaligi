

import UIKit

class SuraHeaderTitleView: UIView {

  private lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "Suralar va Duolar"
    $0.font = .systemFont(ofSize: 30, weight: .semibold)
    $0.textColor = .goldColor
    $0.textAlignment = .center
    return $0
  }(UILabel())

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setConstraints()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = 15
    self.layer.masksToBounds = true
    self.backgroundColor = .fonWhiteColor
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


// MARK: - Init
private extension SuraHeaderTitleView {
  func setup() {
    self.addSubview(titleLabel)
  }

  func setConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}
