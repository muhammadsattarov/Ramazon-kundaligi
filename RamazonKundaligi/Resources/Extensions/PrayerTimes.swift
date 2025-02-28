

import UIKit
import Adhan

extension PrayerTimes {
    func getPrayerTimesAsDates() -> [(String, Date)] {
        return [
            ("Bomdod", fajr),
            ("Quyosh", sunrise),
            ("Peshin", dhuhr),
            ("Asr", asr),
            ("Shom", maghrib),
            ("Xufton", isha)
        ]
    }
}
