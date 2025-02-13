

import UIKit

class HomeTableViewCell: UITableViewCell {
  static let reuseId = "HomeTableViewCell"

  private lazy var titleLabel = UILabel(
    text: "Bomdod",
    font: .systemFont(ofSize: 18, weight: .regular)
  )

  private lazy var timeLabel = UILabel(
    text: "16:00",
    font: .systemFont(ofSize: 18, weight: .medium),
    textAlignment: .center
  )

  private lazy var imageOfView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.image = UIImage(systemName: "sun.max")
    $0.contentMode = .scaleAspectFit
    $0.tintColor = .white
    return $0
  }(UIImageView())

  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = .clear
    contentView.backgroundColor = .cellBackgrountColor
    setup()
    setConstraints()
  }

  func configure(with model: PrayerTimesModel) {
    titleLabel.text = model.title
    timeLabel.text = model.time
    imageOfView.image = UIImage(systemName: model.image)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension HomeTableViewCell {
  func setup() {
    contentView.addSubview(titleLabel)
    contentView.addSubview(timeLabel)
    contentView.addSubview(imageOfView)
  }

  func setConstraints() {
    let space: CGFloat = 20
    NSLayoutConstraint.activate([
      imageOfView.widthAnchor.constraint(equalToConstant: 25),
      imageOfView.heightAnchor.constraint(equalToConstant: 22),
      imageOfView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -space),
      imageOfView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

      timeLabel.rightAnchor.constraint(equalTo: imageOfView.leftAnchor, constant: -space),
      timeLabel.widthAnchor.constraint(equalToConstant: 80),
      timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

      titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: space),
      titleLabel.rightAnchor.constraint(equalTo: timeLabel.leftAnchor, constant: -space),
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
    ])
  }
}
