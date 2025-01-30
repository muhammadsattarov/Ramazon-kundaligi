//
//  SurasViewController.swift
//  RamazonKundaligi
//
//  Created by user on 24/01/25.
//

import UIKit

class SuraViewController: UIViewController {

  private let suraHeaderView = SuraHeaderView()
  private let surasView = SurasView()

  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
}

// MARK: - Setup Views
private extension SuraViewController {
  func setupViews() {
    view.backgroundColor = .fonGreenColor
    addSubviews()
    setConstraints()
  }
}

// MARK: - Add Subviews
private extension SuraViewController {
  func addSubviews() {
    view.addSubview(suraHeaderView)
    suraHeaderView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(surasView)
    surasView.translatesAutoresizingMaskIntoConstraints = false
    surasView.suraAndDua = SuraCollectionTitles.mockData()
  }
}

// MARK: - Constraints
private extension SuraViewController {
  func setConstraints() {
    let space: CGFloat = 30
    let headerViewHeight: CGFloat = windowHeight/2.8
    NSLayoutConstraint.activate([
      suraHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
      suraHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: space),
      suraHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -space),
      suraHeaderView.heightAnchor.constraint(equalToConstant: headerViewHeight),

      surasView.topAnchor.constraint(equalTo: suraHeaderView.bottomAnchor, constant: -20),
      surasView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: space),
      surasView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -space),
    ])
  }
}

