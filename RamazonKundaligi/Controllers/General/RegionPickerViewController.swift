
import UIKit

class RegionPickerViewController: UIViewController {
  // MARK: - UI Components
  private let titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 18, weight: .medium)
    $0.textColor = .white
    $0.textAlignment = .center
    return $0
  }(UILabel())
  
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
    $0.layer.cornerRadius = 12
    $0.clipsToBounds = true
    $0.showsVerticalScrollIndicator = false
    return $0
  }(UITableView(frame: .zero, style: .plain))

  // MARK: - Properties
  var onSelect: ((String, String) -> Void)?
  var isShowingRegions = true // True -> Regions, False -> Districts

  var regions: [Region] = []
  var districts: [District] = []
  var selectedRegion: Region?

  var selectedRegionID: Int? {
    get { UserDefaults.standard.value(forKey: "selectedRegionID") as? Int }
    set { UserDefaults.standard.setValue(newValue, forKey: "selectedRegionID") }
  }

  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }

  override func viewWillAppear(_ animated: Bool) {
    animateBackButton()
    fetchRegion()
    setupTitleLabel()
  }
}

// MARK: - SetupViews
private extension RegionPickerViewController {
  func setupViews() {
    addSubviews()
    setupTableView()
    setConstraints()
    addActions()

    view.backgroundColor = .fonGreenColor2
    view.layer.cornerRadius = 30
    view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
  }
}

// MARK: - Add Subviews
private extension RegionPickerViewController {
  func addSubviews() {
    view.addSubview(backButton)
    view.addSubview(titleLabel)
    view.addSubview(tableView)
  }

  func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.sectionHeaderHeight = 0
    tableView.sectionFooterHeight = 0
    tableView.estimatedSectionHeaderHeight = 0
    tableView.estimatedSectionFooterHeight = 0
  }

  func setupTitleLabel() {
    if isShowingRegions {
      titleLabel.text = "Viloyatlar"
    } else {
      titleLabel.text = "Tuman va shaharlar"
    }
  }
}

// MARK: - Setup data
private extension RegionPickerViewController {
  func fetchRegion() {
    print(#function)
    RamadanService.shared.fetchRegions { regions in
      if let regions {
        DispatchQueue.main.async { [weak self] in
          self?.regions = regions
          self?.restoreSelectedRegion()
          self?.tableView.reloadData()
        }
      }
    }
  }

  func fetchDistrict(id: Int) {
    RamadanService.shared.fetchDistricts(id) { districts in
      if let districts {
        DispatchQueue.main.async {  [weak self] in
          self?.districts = districts
          self?.tableView.reloadData()
        }
      }
    }
  }
}

private extension RegionPickerViewController {
  /// 📌 Saqlangan viloyatni tiklash
  func restoreSelectedRegion() {
    guard let regionID = selectedRegionID,
          let index = regions.firstIndex(where: { $0.id == regionID }) else { return }

    selectedRegion = regions[index]
    tableView.reloadData() // ✅ Yangi yuklangan ma’lumotlar bilan UI yangilash
    fetchDistrict(id: regionID) // ✅ Tanlangan viloyat bo‘yicha tumanlarni yuklash
  }
}

// MARK: - Add Actions
private extension RegionPickerViewController {
  func addActions() {
    backButton.addTarget(
      self,
      action: #selector(didTapBackButton), for: .touchUpInside)
  }

  @objc func didTapBackButton() {
    if !isShowingRegions {
      // 📌 Agar tumanlar ko‘rsatilayotgan bo‘lsa, viloyatlarga qaytish
      titleLabel.text = "Viloyatlar"
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
    let tableSpace: CGFloat = 15
    NSLayoutConstraint.activate([
      backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: space),
      backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: space),
      backButton.widthAnchor.constraint(equalToConstant: 25),
      backButton.heightAnchor.constraint(equalToConstant: 25),

      titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: space),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      tableView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: tableSpace),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: tableSpace),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -tableSpace),
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

    if isShowingRegions {
       let region = regions[indexPath.row]
       cell.textLabel?.text = region.name
       cell.accessoryType = (selectedRegionID == region.id) ? .checkmark : .none  // ✅ ID orqali tekshirish
     } else {
       let district = districts[indexPath.row]
       cell.textLabel?.text = district.name
       cell.accessoryType = .none
     }

    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 45
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if isShowingRegions {
      selectedRegionID = regions[indexPath.row].id
      selectedRegion = regions[indexPath.row]
      fetchDistrict(id: selectedRegion!.id)
      isShowingRegions = false
      animateBackButton(isBack: false)
    } else {
      guard let selectedRegion = selectedRegion else { return }
      let selectedDistrict = districts[indexPath.row]
      UserDefaults.standard.set(selectedDistrict.id, forKey: Constants.districtID)
      onSelect?(selectedRegion.name, selectedDistrict.name)
      dismiss(animated: true)
    }

    setupTitleLabel()
    tableView.reloadData()
  }
}
