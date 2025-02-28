

import Foundation
import ObjectiveC

private var bundleKey: UInt8 = 0

extension Bundle {
    static func setLanguage(_ language: String) {
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return
        }
        objc_setAssociatedObject(Bundle.main, &bundleKey, bundle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    static func localizedString(forKey key: String) -> String {
        let bundle = objc_getAssociatedObject(Bundle.main, &bundleKey) as? Bundle ?? Bundle.main
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
