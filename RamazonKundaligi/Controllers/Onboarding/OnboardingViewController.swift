//
//  OnboardingViewController.swift
//  RamazonKundaligi
//
//  Created by user on 24/01/25.
//

import UIKit

class OnboardingViewController: UIViewController {

  private lazy var imageOfView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.image = UIImage(named: "onboarding")
    $0.contentMode = .scaleToFill
    return $0
  }(UIImageView())

  private lazy var titleLabel = UILabel(
    text: "Ramazon \nMuborak!!!",
    font: .systemFont(ofSize: 40, weight: .bold),
    textColor: .goldColor,
    textAlignment: .center,
    numberOfLines: 2
  )

  private lazy var nextButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    $0.setTitle("Davom etish", for: .normal)
    $0.setTitleColor(.fonGreenColor, for: .normal)
    $0.backgroundColor = .goldColor
    $0.layer.cornerRadius = 25
    $0.clipsToBounds = true
    return $0
  }(UIButton(type: .system))

  // MARK: - Init
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
}

private extension OnboardingViewController {
  func setupViews() {
    view.backgroundColor = .fonGreenColor
    addSubviews()
    setConstraints()
    addActions()
  }
}

private extension OnboardingViewController {
  func addSubviews() {
    view.addSubview(imageOfView)
    view.addSubview(titleLabel)
    view.addSubview(nextButton)
  }
}

private extension OnboardingViewController {
  func addActions() {
    nextButton.addTarget(
      self,
      action: #selector(didTapNextButton),
      for: .touchUpInside
    )
  }

  @objc func didTapNextButton() {
    let vc = MainTabBarController()
    vc.modalPresentationStyle = .overFullScreen
    vc.modalTransitionStyle = .crossDissolve
    present(vc, animated: true)
  }
}

private extension OnboardingViewController {
  func setConstraints() {
    NSLayoutConstraint.activate([
      imageOfView.topAnchor.constraint(equalTo: view.topAnchor),
      imageOfView.leftAnchor.constraint(equalTo: view.leftAnchor),
      imageOfView.rightAnchor.constraint(equalTo: view.rightAnchor),
      imageOfView.heightAnchor.constraint(equalToConstant: windowWidth),

      titleLabel.topAnchor.constraint(equalTo: imageOfView.bottomAnchor, constant: 50),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -windowHeight/4.5),
      nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      nextButton.heightAnchor.constraint(equalToConstant: 50),
      nextButton.widthAnchor.constraint(equalToConstant: windowWidth/1.3)
    ])
  }
}
