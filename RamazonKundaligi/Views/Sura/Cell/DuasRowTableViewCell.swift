

import UIKit

class DuasRowTableViewCell: UITableViewCell {
static let reuseId = "DuasRowTableViewCell"

  private let duaTitleView = DuaTitleView()

  private let arabicLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 16, weight: .medium)
    $0.textColor = .white
    $0.numberOfLines = 0
    $0.textAlignment = .right
    return $0
  }(UILabel())

  private let crilicLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 16, weight: .medium)
    $0.textColor = .goldColor
    $0.numberOfLines = 0
    return $0
  }(UILabel())

  private let meanLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 16, weight: .medium)
    $0.textColor = .white
    $0.numberOfLines = 0
    return $0
  }(UILabel())

  private lazy var vStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.spacing = 15
    return $0
  }(UIStackView(arrangedSubviews: [arabicLabel, crilicLabel, meanLabel]))

  private let containerView: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .cellBackgrountColor
    $0.layer.cornerRadius = 10
    $0.clipsToBounds = true
    return $0
  }(UIView())

  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }

  func configure(with model: Dua) {
    let titlelabel = Bundle.localizedString(forKey: model.title)
    duaTitleView.titleLabel.text = titlelabel
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
    contentView.addSubview(duaTitleView)
    duaTitleView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(containerView)
    containerView.addSubview(vStack)
    setConstraints()
  }

  func setConstraints() {
    let space: CGFloat = 12
    let horizontalSpace: CGFloat = 20
    NSLayoutConstraint.activate([
      duaTitleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
      duaTitleView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: horizontalSpace),
      duaTitleView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -horizontalSpace),
      duaTitleView.heightAnchor.constraint(equalToConstant: 50),

      containerView.topAnchor.constraint(equalTo: duaTitleView.bottomAnchor, constant: space),
      containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: horizontalSpace),
      containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -horizontalSpace),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

      vStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: space),
      vStack.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: space),
      vStack.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -space),
      vStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -space)
    ])
  }
}
