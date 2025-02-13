



 import UIKit

 class CalendarTableViewCell: UITableViewCell {
   static let reuseId = "CalendarTableViewCell"

   // MARK: - Prperties
   private lazy var numberLabel: UILabel = {
     $0.translatesAutoresizingMaskIntoConstraints = false
     $0.text = "No"
     $0.textAlignment = .center
     $0.textColor = .white
   return $0
   }(UILabel())

   private lazy var dateNameLabel: UILabel = {
     $0.translatesAutoresizingMaskIntoConstraints = false
     $0.text = "Day"
     $0.textAlignment = .center
     $0.textColor = .white
   return $0
   }(UILabel())

   private lazy var saharlikTimeimeLabel: UILabel = {
     $0.translatesAutoresizingMaskIntoConstraints = false
     $0.text = "-/-"
     $0.textAlignment = .center
     $0.textColor = .white
   return $0
   }(UILabel())

   private lazy var iftorlikTimeimeLabel: UILabel = {
     $0.translatesAutoresizingMaskIntoConstraints = false
     $0.text = "-/-"
     $0.textAlignment = .center
     $0.textColor = .white
   return $0
   }(UILabel())

   private lazy var baseStack: UIStackView = {
     $0.translatesAutoresizingMaskIntoConstraints = false
     $0.axis = .horizontal
     $0.spacing = 2
     $0.alignment = .center
     $0.distribution = .equalSpacing
     return $0
   }(UIStackView(arrangedSubviews: [numberLabel, dateNameLabel, saharlikTimeimeLabel, iftorlikTimeimeLabel]))

   private let containerView: UIView = {
     $0.translatesAutoresizingMaskIntoConstraints = false
     $0.backgroundColor = .cellBackgrountColor
     return $0
   }(UIView())

   // MARK: - Init
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)
     setup()
     setupLabelFonts()
     setConstraints()
   }

   func configure(with model: CalendarModel) {
     numberLabel.text = model.daynumber
     dateNameLabel.text = model.dayName
     saharlikTimeimeLabel.text = model.saharTime
     iftorlikTimeimeLabel.text = model.iftarTime
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

   func setupLabelFonts() {

     let labelFont: UIFont

     let screenType = UIView.ScreenSizeType.current()
     switch screenType {
     case .small:
       labelFont = .systemFont(ofSize: 15, weight: .medium)
     case .medium:
       labelFont = .systemFont(ofSize: 16, weight: .medium)
     case .large:
       labelFont = .systemFont(ofSize: 16, weight: .medium)
     }
     numberLabel.font = labelFont
     dateNameLabel.font = labelFont
     saharlikTimeimeLabel.font = labelFont
     iftorlikTimeimeLabel.font = labelFont
   }

   func setConstraints() {
     
     let itemWidth: CGFloat = 65

     NSLayoutConstraint.activate([
       containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
       containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
       containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
       containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),

       numberLabel.widthAnchor.constraint(equalToConstant: itemWidth),
       dateNameLabel.widthAnchor.constraint(equalToConstant: itemWidth),
       saharlikTimeimeLabel.widthAnchor.constraint(equalToConstant: itemWidth),
       iftorlikTimeimeLabel.widthAnchor.constraint(equalToConstant: itemWidth),

       baseStack.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
       baseStack.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),
       baseStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
     ])
   }
 }

