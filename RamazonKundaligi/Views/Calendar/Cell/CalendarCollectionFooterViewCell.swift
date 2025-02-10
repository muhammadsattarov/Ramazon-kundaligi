

import UIKit

class CalendarCollectionFooterViewCell: UICollectionViewCell {
  static let reuseId = "CalendarCollectionFooterViewCell"

  // MARK: - Prperties
  private lazy var numberLabel = UILabel(
    text: "1",
    font: .systemFont(ofSize: 15, weight: .medium),
    textAlignment: .center
  )
  private lazy var dateLabel = UILabel(
    text: "11-Mart",
    font: .systemFont(ofSize: 15, weight: .medium),
    textAlignment: .center
  )
  private lazy var saharlikTimeimeLabel = UILabel(
    text: "05:14",
    font: .systemFont(ofSize: 15, weight: .medium),
    textAlignment: .center
  )
  private lazy var iftorlikTimeimeLabel = UILabel(
    text: "18:19",
    font: .systemFont(ofSize: 15, weight: .medium),
    textAlignment: .center
  )

  private lazy var baseStack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.spacing = 10
    $0.alignment = .center
    $0.distribution = .equalSpacing
    return $0
  }(UIStackView(arrangedSubviews: [numberLabel, dateLabel, saharlikTimeimeLabel, iftorlikTimeimeLabel]))

  private let containerView: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .cellBackgrountColor
    return $0
  }(UIView())

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup UI and Constraints
private extension CalendarCollectionFooterViewCell {
  func setup() {
    self.backgroundColor = .clear
    contentView.backgroundColor = .clear
    contentView.addSubview(containerView)
    containerView.addSubview(baseStack)
  }

  func setConstraints() {
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),

      baseStack.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
      baseStack.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),
      baseStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
    ])
  }
}


/*

 import UIKit

 class CalendarTableViewCell: UITableViewCell {
   static let reuseId = "CalendarTableViewCell"

   // MARK: - Prperties
   private lazy var numberLabel = UILabel(
     text: "1",
     font: .systemFont(ofSize: 15, weight: .medium),
     textAlignment: .center
   )
   private lazy var dateLabel = UILabel(
     text: "11-Mart",
     font: .systemFont(ofSize: 15, weight: .medium),
     textAlignment: .center
   )
   private lazy var saharlikTimeimeLabel = UILabel(
     text: "05:14",
     font: .systemFont(ofSize: 15, weight: .medium),
     textAlignment: .center
   )
   private lazy var iftorlikTimeimeLabel = UILabel(
     text: "18:19",
     font: .systemFont(ofSize: 15, weight: .medium),
     textAlignment: .center
   )

   private lazy var baseStack: UIStackView = {
     $0.translatesAutoresizingMaskIntoConstraints = false
     $0.axis = .horizontal
     $0.spacing = 10
     $0.alignment = .center
     $0.distribution = .equalSpacing
     return $0
   }(UIStackView(arrangedSubviews: [numberLabel, dateLabel, saharlikTimeimeLabel, iftorlikTimeimeLabel]))

   private let containerView: UIView = {
     $0.translatesAutoresizingMaskIntoConstraints = false
     $0.backgroundColor = .cellBackgrountColor
     return $0
   }(UIView())

   // MARK: - Init
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)
     setup()
     setConstraints()
   }

   required init?(coder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
   }
 }

 // MARK: - Setup UI and Constraints
 private extension CalendarTableViewCell {
   func setup() {
     self.backgroundColor = .clear
     contentView.backgroundColor = .clear
     contentView.addSubview(containerView)
     containerView.addSubview(baseStack)
   }

   func setConstraints() {
     NSLayoutConstraint.activate([
       containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
       containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
       containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
       containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),

       baseStack.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
       baseStack.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),
       baseStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
     ])
   }
 }

 */
