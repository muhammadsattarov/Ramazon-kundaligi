


import UIKit

extension UIViewController {
    func observeLanguageChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name("LanguageChanged"), object: nil)
        updateUI() // Boshlang‘ich tilni yuklash
    }

    @objc func updateUI() {
        // Har bir ViewController o‘ziga xos UI elementlarini yangilashi kerak
    }
}

// MARK: - Custom Alert
extension UIViewController {
  func showCustomAlert(title: String,
                       buttonTitle: String?,
                       isLarge: Bool,
                       okAction: @escaping () -> Void) {
    // Add blur effect
    let blurEffectView = addBlurEffect()

    let alert = CustomAlert(title: title, buttonTitle: buttonTitle)
    alert.alpha = 0
    view.addSubview(alert)

    let alertWidth: CGFloat
    let alertHeight: CGFloat

    let screenType = UIView.ScreenSizeType.current()
    if isLarge {
      switch screenType {
      case .small:
        alertWidth = windowWidth-55
        alertHeight = windowHeight/3
      case .mini:
        alertWidth = windowWidth-60
        alertHeight = windowHeight/4
      case .pro:
        alertWidth = windowWidth-50
        alertHeight = windowHeight/4.5
      case .proMax:
        alertWidth = windowWidth-60
        alertHeight = windowHeight/4.8
      }
    } else {
      switch screenType {
      case .small:
        alertWidth = windowWidth-60
        alertHeight = windowHeight/5.5
      case .mini:
        alertWidth = windowWidth-60
        alertHeight = windowHeight/7
      case .pro:
        alertWidth = windowWidth-60
        alertHeight = windowHeight/7
      case .proMax:
        alertWidth = windowWidth-60
        alertHeight = windowHeight/7
      }
    }

    NSLayoutConstraint.activate([
      alert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      alert.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      alert.widthAnchor.constraint(equalToConstant: alertWidth),
      alert.heightAnchor.constraint(equalToConstant: alertHeight)
    ])

    alert.configureActions(cancelAction: {
      self.dismissAlert(alert, blurEffectView: blurEffectView)
    })

    // Animate the alert appearance
    UIView.animate(withDuration: 0.3) {
      alert.alpha = 1
    }

  }

  private func dismissAlert(_ alert: UIView) {
    UIView.animate(withDuration: 0.3, animations: {
      alert.alpha = 0
    }) { _ in
      alert.removeFromSuperview()
    }
  }

  private func dismissAlert(_ alert: UIView, blurEffectView: UIVisualEffectView) {
    UIView.animate(withDuration: 0.3, animations: {
      alert.alpha = 0
      blurEffectView.effect = nil
    }) { _ in
      alert.removeFromSuperview()
      blurEffectView.removeFromSuperview()
    }
  }

  // Add blur effect to View
  private func addBlurEffect() -> UIVisualEffectView {
    let blurEffect = UIBlurEffect(style: .light)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.translatesAutoresizingMaskIntoConstraints = false
    blurEffectView.alpha = 0.8
    view.addSubview(blurEffectView)

    NSLayoutConstraint.activate([
      blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
      blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

    return blurEffectView
  }
}


// MARK: - Alert
extension UIViewController {
  func customAlert(text: String) {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.showCustomAlert(title: text,
                           buttonTitle: Bundle.localizedString(forKey: "Yopish"),
                           isLarge: false) {
        print("Alert")
      }
    }
  }
}
