//
//  SceneDelegate.swift
//  RamazonKundaligi
//
//  Created by user on 24/01/25.
//

import UIKit
import CoreLocation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  private let location = CLLocationManager()

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: scene)
    window?.overrideUserInterfaceStyle = .light
    window?.rootViewController = LaunchScreenViewController()
    window?.makeKeyAndVisible()
  }

  func sceneDidDisconnect(_ scene: UIScene) {
    UserDefaults.standard.set(false, forKey: Constants.didShowAlert)
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
    let status = location.authorizationStatus

    if status == .denied || status == .restricted {
      if let topVC = UIViewController.getTopViewController() {
        topVC.checkUserAccessLocationAlert()
      }
    }
  }

  func sceneWillResignActive(_ scene: UIScene) {}

  func sceneWillEnterForeground(_ scene: UIScene) {}

  func sceneDidEnterBackground(_ scene: UIScene) {}
}

