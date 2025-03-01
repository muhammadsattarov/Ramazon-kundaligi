

import UIKit

class CustomAlert: UIView {

  private lazy var titleLabel: UILabel = {
    $0.textAlignment = .center
    $0.numberOfLines = 0
    $0.font = .systemFont(ofSize: 15, weight: .regular)
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.textColor = .black
    return $0
  }(UILabel())

  private let cancelButton: UIButton = {
    $0.setTitle("Cancel", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = .systemOrange
    $0.layer.cornerRadius = 10
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(UIButton(type: .system))

  private var cancelAction: (() -> Void)?

  // MARK: - Init
  init(title: String, buttonTitle: String?) {
    super.init(frame: .zero)
    titleLabel.text = title
    cancelButton.setTitle(buttonTitle, for: .normal)
    setup()
    setConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func configureActions(cancelAction: @escaping () -> Void) {
    self.cancelAction = cancelAction

    cancelButton.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
  }
}

// MARK: - Setup and Constrains
private extension CustomAlert {
  func setup() {
    backgroundColor = .systemBackground
    layer.cornerRadius = 15
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.2
    layer.shadowOffset = CGSize(width: 0, height: 3)
    layer.shadowRadius = 3
    translatesAutoresizingMaskIntoConstraints = false

    addSubview(titleLabel)
    addSubview(cancelButton)
  }

  func setConstraints() {
    let labelFont: UIFont
    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      labelFont = .systemFont(ofSize: 15, weight: .regular)
    case .mini:
      labelFont = .systemFont(ofSize: 15, weight: .regular)
    case .pro:
      labelFont = .systemFont(ofSize: 15, weight: .regular)
    case .proMax:
      labelFont = .systemFont(ofSize: 16, weight: .regular)
    }
    titleLabel.font = labelFont

    let titleSpace: CGFloat = 15
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: titleSpace),
      titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: titleSpace),
      titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -titleSpace),

      cancelButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: titleSpace),
      cancelButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
      cancelButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
      cancelButton.heightAnchor.constraint(equalToConstant: 35),
      cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
    ])
  }
}

// MARK: - Actions
private extension CustomAlert {
  @objc private func handleCancelButton() {
    cancelAction?()
  }
}
