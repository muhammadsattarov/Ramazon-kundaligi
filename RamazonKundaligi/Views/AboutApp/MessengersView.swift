

import UIKit

protocol MessengersViewProtocol: AnyObject {
  func telegramIconTapped()
  func instaIconTapped()
}

class MessengersView: UIView {

  lazy var telegramImage: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.image = UIImage(named: "telegram")
    $0.contentMode = .scaleAspectFit
    $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
    $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
    $0.isUserInteractionEnabled = true
    return $0
  }(UIImageView())

  lazy var instaImage: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
    $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
    $0.image = UIImage(named: "insta")
    $0.contentMode = .scaleAspectFit
    $0.isUserInteractionEnabled = true
    return $0
  }(UIImageView())

  lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.textColor = .lightGray
    $0.textAlignment = .center
    $0.font = .systemFont(ofSize: 13, weight: .regular)
    return $0
  }(UILabel())

  private lazy var imageStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.spacing = 15
    return $0
  }(UIStackView(arrangedSubviews: [telegramImage, instaImage]))

  weak var delegate: MessengersViewProtocol?

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
private extension MessengersView {
  func setupUI() {
    self.backgroundColor = .clear
    self.addSubview(imageStack)
    self.addSubview(titleLabel)

    setConstraints()
    addActions()
  }

  func setConstraints() {
    NSLayoutConstraint.activate([
      imageStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      imageStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),

      titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    ])
  }
}

private extension MessengersView {
  func addActions() {
    let telegramGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTelegram))
    let instaGesture = UITapGestureRecognizer(target: self, action: #selector(didTapInsta))

    telegramImage.addGestureRecognizer(telegramGesture)
    instaImage.addGestureRecognizer(instaGesture)
  }

  @objc func didTapTelegram() {
    delegate?.telegramIconTapped()
  }

  @objc func didTapInsta() {
    delegate?.instaIconTapped()
  }
}
