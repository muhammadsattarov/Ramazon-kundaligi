
import UIKit

class RegionPickerViewController: UIViewController {

  private let backButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setImage(UIImage(systemName: "xmark"), for: .normal)
    $0.tintColor = .white
    return $0
  }(UIButton(type: .system))

  private let tableView: UITableView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.register(UITableViewCell.self,
                forCellReuseIdentifier: "cell")
    $0.separatorStyle = .singleLine
    $0.separatorColor = .white
    $0.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
    $0.backgroundColor = .clear
    $0.bounces = false
    $0.showsVerticalScrollIndicator = false
    return $0
  }(UITableView(frame: .zero, style: .insetGrouped))

  var onSelect: ((String, String) -> Void)?
  var isShowingRegions = true // True -> Viloyatlar, False -> Tumanlar

  var regions: [Region] = []
  var districts: [String] = []
  var districtsFromBackend: [String] = [ "District1", "District2", "District3", "District4", "District5"]
  var selectedRegion: Region?

  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }

  override func viewWillAppear(_ animated: Bool) {
    animateBackButton()
    setupData()
  }
}

// MARK: - SetupViews
private extension RegionPickerViewController {
  func setupViews() {
    view.backgroundColor = .fonGreenColor
    addSubviews()
    setConstraints()
    addActions()

    view.layer.cornerRadius = 30
    view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
  }
}

// MARK: - Add Subviews
private extension RegionPickerViewController {
  func addSubviews() {
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)
    view.addSubview(backButton)
  }
}

// MARK: - Setup data
private extension RegionPickerViewController {
  // 📌 1️⃣ Viloyat va tumanlarni yuklash
  func setupData() {
    print(#function)
    CalendarService.shared.fetchRegions { result in
      switch result {
      case .success(let regions):
        DispatchQueue.main.async { [weak self] in
          print("Regions", regions)
          self?.regions = regions
          self?.tableView.reloadData()
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
// MARK: - Set Constraints
private extension RegionPickerViewController {
  func addActions() {
    backButton.addTarget(
      self,
      action: #selector(didTapBackButton), for: .touchUpInside)
  }

  @objc func didTapBackButton() {
    if !isShowingRegions {
      // 📌 Agar tumanlar ko‘rsatilayotgan bo‘lsa, viloyatlarga qaytish
      isShowingRegions = true
      tableView.reloadData()
    } else {
      // 📌 Agar viloyatlar ekrani bo‘lsa, ekranni yopish
      dismiss(animated: true)
    }
  }

  func animateBackButton(isBack: Bool = true) {
    UIView.animate(withDuration: 0.3) { [weak self] in
      if isBack {
        self?.backButton.setImage(UIImage(systemName: "xmark"), for: .normal)
      } else {
        self?.backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
      }
    }
  }
}

// MARK: - Set Constraints
private extension RegionPickerViewController {
  func setConstraints() {
    let space: CGFloat = 20
    NSLayoutConstraint.activate([
      backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: space),
      backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: space),
      backButton.widthAnchor.constraint(equalToConstant: 25),
      backButton.heightAnchor.constraint(equalToConstant: 25),

      tableView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 15),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
    ])
  }
}

extension RegionPickerViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isShowingRegions ? regions.count : districts.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.font = .systemFont(ofSize: 16, weight: .regular)
    cell.backgroundColor = .cellBackgrountColor
    cell.selectionStyle = .none
    cell.textLabel?.textColor = .white
    cell.textLabel?.text = isShowingRegions ? regions[indexPath.row].name : districts[indexPath.row]
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 45
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let cell = tableView.cellForRow(at: indexPath)
    cell?.accessoryType = .checkmark

    if isShowingRegions {
      // 📌 Viloyat tanlandi, tumanlar ro‘yxatini yuklash
      UIView.animate(withDuration: 0.3) { [weak self] in
        self?.animateBackButton(isBack: false)
        self?.selectedRegion = self?.regions[indexPath.row]
        self?.districts = self?.districtsFromBackend ?? []
        self?.isShowingRegions = false
        self?.tableView.reloadData()
      }
    } else {
      // 📌 Tuman tanlandi, natijani qaytarish va ekranni yopish
      animateBackButton(isBack: true)
      guard let selectedRegion = selectedRegion else { return }
      let selectedDistrict = districts[indexPath.row]
      onSelect?(selectedRegion.name, selectedDistrict)
      dismiss(animated: true)
    }
  }
}
