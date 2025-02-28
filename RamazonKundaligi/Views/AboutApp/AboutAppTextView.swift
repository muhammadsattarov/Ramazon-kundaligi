

import UIKit

class AboutAppTextView: UIView {

  private let textLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.numberOfLines = 0
    $0.font = .systemFont(ofSize: 15, weight: .regular)
    $0.textColor = .white
    $0.textAlignment = .center
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
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup UI and Constraints
private extension AboutAppTextView {
  func setupUI() {
    self.backgroundColor = .clear
    self.addSubview(containerView)
    containerView.addSubview(textLabel)
    textLabel.text = """
Ushbu ilova Ramazon oyida hamyurtlarimizga mo'min-musulmonlar uchun kundalik hayotda kerak bo'lib turadigan namoz va ro'za taqvimini o'z ichiga olgan. Ramazon taqvimi O'zbekiston musulmonlar idorasi tomonidan taqdim etilgan taqvimga asoslangan holda yaratilgan. Agar ilovamiz kimgadir foydali bo'lsa biz bundan mamnunmiz.
"""
  }

  func setConstraints() {
    let space: CGFloat = 15
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: space),
      containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: space),
      containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -space),
      containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -space),

      textLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: space),
      textLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: space),
      textLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -space),
      textLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -space),

    ])
  }
}
