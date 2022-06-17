//
//  JailbreakDetection.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation

enum JailBreakPath: String {
    case cydia = "/Applications/Cydia.app"
    case mobileSubstrate = "/Library/MobileSubstrate/MobileSubstrate.dylib"
    case bash = "/bin/bash"
    case sshd = "/usr/sbin/sshd"
    case apt = "/etc/apt"
    case ssh = "/usr/bin/ssh"
    case privateApt = "/private/var/lib/apt"
}

enum JailbreakDetection {
    static var shouldShowJailbreakWarning = false

    static func isBroken() -> Bool {
        return KeeperCommon.shared.isJailBroken
    }

    private static func saveBrokenStatus(_ isBroken: Bool) {
        KeeperCommon.shared.isJailBroken = isBroken
    }

    static func inspectDevice() {
        let previousResult = JailbreakDetection.isBroken()
        let isBroken = JailbreakDetection.checkIfBroken()
        saveBrokenStatus(isBroken)

        if !previousResult, isBroken {
            shouldShowJailbreakWarning = true
        }
    }

    private static func checkIfBroken() -> Bool {
        guard let cydiaUrlScheme = NSURL(string: "cydia://package/com.example.package") else { return false }

        #if arch(i386) || arch(x86_64) || TARGET_IPHONE_SIMULATOR
            // This is a Simulator not a device
            return false
        #else

            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: JailBreakPath.cydia.rawValue) ||
                fileManager.fileExists(atPath: JailBreakPath.mobileSubstrate.rawValue) ||
                fileManager.fileExists(atPath: JailBreakPath.bash.rawValue) ||
                fileManager.fileExists(atPath: JailBreakPath.sshd.rawValue) ||
                fileManager.fileExists(atPath: JailBreakPath.apt.rawValue) ||
                fileManager.fileExists(atPath: JailBreakPath.ssh.rawValue) ||
                fileManager.fileExists(atPath: JailBreakPath.privateApt.rawValue) {
                return true
            }

            if canOpen(path: JailBreakPath.cydia.rawValue) ||
                canOpen(path: JailBreakPath.mobileSubstrate.rawValue) ||
                canOpen(path: JailBreakPath.bash.rawValue) ||
                canOpen(path: JailBreakPath.sshd.rawValue) ||
                canOpen(path: JailBreakPath.apt.rawValue) ||
                canOpen(path: JailBreakPath.ssh.rawValue) {
                return true
            }

            var result = false
            ["/", "/private/", "/Applications/", "/System/", "/bin/"].forEach { item in
                let path = item + NSUUID().uuidString
                do {
                    try "anyString".write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
                    try fileManager.removeItem(atPath: path)
                    result = true
                } catch {}
            }

            return result
        #endif
    }

    static func canOpen(path: String) -> Bool {
        let file = fopen(path, "r")
        guard file != nil else { return false }
        fclose(file)
        return true
    }
}
