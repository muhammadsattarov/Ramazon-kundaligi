

import UIKit

class SupportView: UIView {

  private lazy var iconImage: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
 //   $0.image = UIImage(systemName: "location")
    $0.contentMode = .scaleAspectFit
    $0.tintColor = .goldColor
    return $0
  }(UIImageView())

  let textLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.textColor = .white
    $0.text = "Qo'llab-quvvatlash xizmati"
    return $0
  }(UILabel())

  private let containerView: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .cellBackgrountColor
    $0.layer.cornerRadius = 15
    $0.clipsToBounds = true
    return $0
  }(UIView())

  // MARK: - Init
  init(title: String, icon: String) {
    super.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    iconImage.image = UIImage(systemName: icon)
    textLabel.text = title
    setupUI()
    setConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup UI and Constraints
private extension SupportView {
  func setupUI() {
    self.backgroundColor = .clear
    self.addSubview(containerView)
    containerView.addSubview(iconImage)
    containerView.addSubview(textLabel)
  }

  func setConstraints() {
    let space: CGFloat = 15
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
      containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: space),
      containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -space),
      containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),

      iconImage.widthAnchor.constraint(equalToConstant: 25),
      iconImage.heightAnchor.constraint(equalToConstant: 25),
      iconImage.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: space),
      iconImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
      iconImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),

      textLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 7),
      textLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
    ])
  }
}

