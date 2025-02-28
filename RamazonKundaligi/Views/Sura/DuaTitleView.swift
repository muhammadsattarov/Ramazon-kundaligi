

import UIKit

class DuaTitleView: UIView {

  lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 17, weight: .semibold)
    $0.textColor = .white
    return $0
  }(UILabel())

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


// MARK: - Setup UI and Constraints
private extension DuaTitleView {
  func setupUI() {
    self.backgroundColor = .cellBackgrountColor
    self.layer.cornerRadius = 10
    self.clipsToBounds = true

    self.addSubview(titleLabel)

    setConstraints()
  }

  func setConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
      titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
      titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}
