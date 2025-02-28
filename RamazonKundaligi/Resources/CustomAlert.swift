

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

  private let okButton: UIButton = {
    $0.setTitle("yes", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = .systemOrange
    $0.layer.cornerRadius = 10
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(UIButton(type: .system))

  private let cancelButton: UIButton = {
    $0.setTitle("no", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = .secondarySystemBackground
    $0.layer.cornerRadius = 10
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(UIButton(type: .system))

  private lazy var buttonStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.spacing = 10
    $0.distribution = .fillEqually
    return $0
  }(UIStackView(arrangedSubviews: [okButton]))

  private var okAction: (() -> Void)?
  private var cancelAction: (() -> Void)?

  // MARK: - Init
  init(title: String, showCancelButton: Bool = true, buttonTitle: String?) {
    super.init(frame: .zero)
    titleLabel.text = title
    if !showCancelButton {
      okButton.setTitle(buttonTitle, for: .normal)
    }
    setup(showCancelButton: showCancelButton)
    setConstraints()
  }

  func setupLabelFonts() {
    let labelFont: UIFont
    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      labelFont = .systemFont(ofSize: 12, weight: .regular)
    case .mini:
      labelFont = .systemFont(ofSize: 15, weight: .regular)
    case .pro:
      labelFont = .systemFont(ofSize: 15, weight: .regular)
    case .proMax:
      labelFont = .systemFont(ofSize: 16, weight: .regular)
    }
    titleLabel.font = labelFont
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func configureActions(okAction: @escaping () -> Void, cancelAction: @escaping () -> Void) {
    self.okAction = okAction
    self.cancelAction = cancelAction

    okButton.addTarget(self, action: #selector(handleOkButton), for: .touchUpInside)
    cancelButton.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
  }
}

// MARK: - Setup and Constrains
private extension CustomAlert {
  func setup(showCancelButton: Bool) {
    backgroundColor = .systemBackground
    layer.cornerRadius = 15
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.2
    layer.shadowOffset = CGSize(width: 0, height: 3)
    layer.shadowRadius = 3
    translatesAutoresizingMaskIntoConstraints = false

    addSubview(titleLabel)
    addSubview(buttonStack)

    if showCancelButton {
      buttonStack.addArrangedSubview(cancelButton)
    }
  }

  func setConstraints() {
    let titleSpace: CGFloat = 15
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: titleSpace),
      titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: titleSpace),
      titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -titleSpace),

      buttonStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: titleSpace),
      buttonStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
      buttonStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
      buttonStack.heightAnchor.constraint(equalToConstant: 35),
      buttonStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
    ])
  }
}

// MARK: - Actions
private extension CustomAlert {
  @objc private func handleOkButton() {
    okAction?()
  }

  @objc private func handleCancelButton() {
    cancelAction?()
  }
}
