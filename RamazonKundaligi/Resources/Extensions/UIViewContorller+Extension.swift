


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
                       okAction: @escaping () -> Void) {
    // Add blur effect
    let blurEffectView = addBlurEffect()

    let alert = CustomAlert(title: title, buttonTitle: buttonTitle)
    alert.alpha = 0
    view.addSubview(alert)

    NSLayoutConstraint.activate([
      alert.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      alert.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
      alert.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
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
                           buttonTitle: Bundle.localizedString(forKey: "Yopish")) {
        print("Alert")
      }
    }
  }

  func checkUserAccessLocationAlert() {
    let alert = UIAlertController(
      title: "Ilovani ishlashi uchun joylashuvni kuzatishga ruhsat bering.",
      message: "Iltimos serverdan malumotlarni olish uchun joylashuv sozlamalariga ruhsat bering.", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Sozlamalarga o'tish",
                                  style: .default, handler: { _ in
      if let settingsURL = URL(string: UIApplication.openSettingsURLString),
         UIApplication.shared.canOpenURL(settingsURL) {
        UIApplication.shared.open(settingsURL)
      }
    }))
    present(alert, animated: true)
  }
}

extension UIViewController {
  static func getTopViewController() -> UIViewController? {
        if let topVC = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })?.rootViewController {
            return topVC
        }
        return nil
    }
}
