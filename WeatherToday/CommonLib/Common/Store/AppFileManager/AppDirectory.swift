//
//  AppDirectory.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public enum AppDirectories {
    case documents
    case inbox
    case library
    case temp
    case container(appGroup: String)
}

public extension AppDirectories {
    func getURL() -> URL? {
        switch self {
        case .documents:
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        case .inbox:
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                .appendingPathComponent("Inbox")
        case .library:
            return FileManager.default.urls(for: FileManager.SearchPathDirectory.libraryDirectory, in: .userDomainMask)
                .first
        case .temp:
            return FileManager.default.temporaryDirectory
        case let .container(appGroup):
            return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup)
        }
    }

    func buildFullPath(forFileName name: String) -> URL? {
        guard let url = getURL() else { return nil }
        return url.appendingPathComponent(name)
    }
}
