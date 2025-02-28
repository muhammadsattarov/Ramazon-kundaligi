

import UIKit

class SurasRowTableViewCell: UITableViewCell {
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
    $0.textColor = .white
    $0.numberOfLines = 0
    return $0
  }(UILabel())

  private let meanLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 18, weight: .regular)
    $0.textColor = .orange
    $0.numberOfLines = 0
    return $0
  }(UILabel())

  private lazy var vStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.spacing = 10
    return $0
  }(UIStackView(arrangedSubviews: [titleLabel, arabicLabel, crilicLabel, meanLabel]))

  private let containerView: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .cellBackgrountColor
    $0.layer.cornerRadius = 20
    $0.clipsToBounds = true
    return $0
  }(UIView())

  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }

  func configure(with model: Dua) {
    titleLabel.text = model.title
    arabicLabel.text = model.arabicText
    crilicLabel.text = model.transliteration
    meanLabel.text = model.meaning
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup UI and Constraints
private extension SurasRowTableViewCell {
  func setupUI() {
    self.selectionStyle = .none
    self.backgroundColor = .clear
    contentView.addSubview(containerView)
    containerView.addSubview(vStack)

    setConstraints()
  }

  func setConstraints() {
    let verticalSpace: CGFloat = 10
    let horizontalSpace: CGFloat = 20
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalSpace),
      containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: horizontalSpace),
      containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -horizontalSpace),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalSpace),

      vStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: verticalSpace),
      vStack.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: horizontalSpace),
      vStack.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -horizontalSpace),
      vStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -verticalSpace)
    ])
  }
}
