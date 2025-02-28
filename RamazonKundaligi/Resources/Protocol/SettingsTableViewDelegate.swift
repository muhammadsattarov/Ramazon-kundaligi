
import UIKit

protocol SettingsTableViewDelegate: AnyObject {
  func didTapSelectLocationName()
  func didTapLanguageChanged(_ sender: UISegmentedControl)
  func didTapShareApp()
  func didTapAppEvalution()
  func didTapNotification(_ sender: UISwitch)
  func didTapAboutApp()
}
