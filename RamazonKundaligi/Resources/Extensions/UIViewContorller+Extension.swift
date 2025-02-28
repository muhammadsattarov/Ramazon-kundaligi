


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

extension UIViewController {
  func showCustomAlert(title: String,
                       showCancelButton: Bool,
                       buttonTitle: String?,
                       okAction: @escaping () -> Void) {
    // Add blur effect
    let blurEffectView = addBlurEffect()

    let alert = CustomAlert(title: title, showCancelButton: showCancelButton, buttonTitle: buttonTitle)
    alert.alpha = 0
    view.addSubview(alert)

    let alertWidth: CGFloat
    let alertHeight: CGFloat

    let screenType = UIView.ScreenSizeType.current()
    switch screenType {
    case .small:
      alertWidth = windowWidth-55
      alertHeight = windowHeight/3.2
    case .mini:
      alertWidth = windowWidth-60
      alertHeight = windowHeight/4
    case .pro:
      alertWidth = windowWidth-50
      alertHeight = windowHeight/4.5
    case .proMax:
      alertWidth = windowWidth-60
      alertHeight = windowHeight/5
    }

    NSLayoutConstraint.activate([
      alert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      alert.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      alert.widthAnchor.constraint(equalToConstant: alertWidth),
      alert.heightAnchor.constraint(equalToConstant: alertHeight)
    ])

    alert.configureActions(okAction: {
      okAction()
      self.dismissAlert(alert, blurEffectView: blurEffectView)
    }, cancelAction: {
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
