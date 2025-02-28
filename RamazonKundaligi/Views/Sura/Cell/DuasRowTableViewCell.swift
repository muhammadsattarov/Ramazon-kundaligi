

import UIKit

class DuasRowTableViewCell: UITableViewCell {
static let reuseId = "SurasRowTableViewCell"

  private let titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 20, weight: .semibold)
    $0.textColor = .goldColor
    $0.numberOfLines = 0
    return $0
  }(UILabel())

  private let arabicLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 18, weight: .regular)
    $0.textColor = .systemBlue
    $0.numberOfLines = 0
    return $0
  }(UILabel())

  private let crilicLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 18, weight: .regular)
    $0.textColor = .goldColor
    $0.numberOfLines = 0
    return $0
  }(UILabel())

  private let meanLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 18, weight: .regular)
    $0.textColor = .white
    $0.numberOfLines = 0
    return $0
  }(UILabel())

  private lazy var vStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.spacing = 10
    return $0
  }(UIStackView(arrangedSubviews: [titleLabel, arabicLabel, crilicLabel, meanLabel]))

  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }

  func configure(with model: Dua) {
    let titlelabel = Bundle.localizedString(forKey: model.title)
    titleLabel.setBulletText(titlelabel, bulletColor: .goldColor)
    arabicLabel.text = model.arabicText
    crilicLabel.text = Bundle.localizedString(forKey: model.transliteration)
    meanLabel.text = Bundle.localizedString(forKey: model.meaning)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup UI and Constraints
private extension DuasRowTableViewCell {
  func setupUI() {
    self.selectionStyle = .none
    self.backgroundColor = .clear
    contentView.addSubview(vStack)

    setConstraints()
  }

  func setConstraints() {
    let space: CGFloat = 20
    NSLayoutConstraint.activate([
      vStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: space),
      vStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: space),
      vStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -space),
      vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -space)
    ])
  }
}


extension UILabel {
    func setBulletText(_ text: String, bulletColor: UIColor = .goldColor, textColor: UIColor = .goldColor, fontSize: CGFloat = 20) {
        let bullet = "•"  // Dumaloq nuqta
        let fullText = "\(bullet) \(text)"

        let attributedString = NSMutableAttributedString(string: fullText)

        // Nuqtaning rangi
        attributedString.addAttribute(.foregroundColor, value: bulletColor, range: NSRange(location: 0, length: 1))

        // Barcha matn uchun shrift va rang
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: fontSize), range: NSRange(location: 0, length: fullText.count))
        attributedString.addAttribute(.foregroundColor, value: textColor, range: NSRange(location: 2, length: text.count))

        self.attributedText = attributedString
    }
}
