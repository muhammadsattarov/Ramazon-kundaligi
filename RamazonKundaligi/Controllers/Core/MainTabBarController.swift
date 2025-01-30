//
//  ViewController.swift
//  RamazonKundaligi
//
//  Created by user on 24/01/25.
//

import UIKit

class MainTabBarController: UITabBarController {

  private let homeVC = UINavigationController(rootViewController: HomeViewController())
  private let calendarVC = UINavigationController(rootViewController: CalendarViewController())
  private let surasVC = UINavigationController(rootViewController: SuraViewController())
  private let settingsVC = UINavigationController(rootViewController: SettingsViewController())

  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
}

private extension MainTabBarController {
  func setupViews() {

    tabBar.isTranslucent = true
    tabBar.backgroundColor = .white

    tabBar.tintColor = .fonGreenColor
    homeVC.tabBarItem.image = UIImage(systemName: "house")
    homeVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")

    calendarVC.tabBarItem.image = UIImage(systemName: "calendar")
    calendarVC.tabBarItem.selectedImage = UIImage(systemName: "calendar")

    surasVC.tabBarItem.image = UIImage(systemName: "book")
    surasVC.tabBarItem.selectedImage = UIImage(systemName: "book.fill")

    settingsVC.tabBarItem.image = UIImage(systemName: "gearshape")
    settingsVC.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")

    setViewControllers([homeVC, calendarVC, surasVC, settingsVC], animated: true)
  }
}

