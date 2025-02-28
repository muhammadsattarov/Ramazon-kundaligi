


import UIKit

class SettingsTableViewCell: UITableViewCell {
static let reuseId = "SettingsTableViewCell"
  
  lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 15, weight: .regular)
    $0.textColor = .white
    $0.textAlignment = .center
    return $0
  }(UILabel())

  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = .cellBackgrountColor
    contentView.addSubview(titleLabel)
    self.selectionStyle = .none
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
