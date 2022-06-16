//
//  Bundle+Version.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation

extension Bundle {
    var versionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }

    var prettyVersionString: String {
        let ver = versionNumber ?? "Unknown"
        let build = buildNumber ?? "0"
        let format = NSLocalizedString("Version %@ (%@)", comment: "")
        return String.localizedStringWithFormat(format, ver, build)
    }
}
