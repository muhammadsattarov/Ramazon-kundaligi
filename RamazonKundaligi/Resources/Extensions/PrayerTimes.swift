//
//  prayer.swift
//  RamazonKundaligi
//
//  Created by user on 25/02/25.
//

import Foundation

extension PrayerTimes {
    func getPrayerTimesAsDates() -> [(String, Date)] {
        return [
            ("Bomdod", fajr),
            ("Quyosh", sunrise),
            ("Peshin", dhuhr),
            ("Asr", asr),
            ("Shom", maghrib),
            ("Xufton"
