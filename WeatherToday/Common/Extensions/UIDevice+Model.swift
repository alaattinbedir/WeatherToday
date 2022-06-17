//
//  UIDevice+Model.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import UIKit

public enum DeviceModel: CaseIterable {
    case iPhone4, iPhone4S
    case iPhone5, iPhone5C, iPhone5S
    case iPhone6, iPhone6Plus
    case iPhone6S, iPhone6SPlus
    case iPhoneSE, iPhoneSE2
    case iPhone7, iPhone7Plus
    case iPhone8, iPhone8Plus
    case iPhoneX
    case iPhoneXS, iPhoneXSMax
    case iPhoneXR
    case iPhone11
    case iPhone11Pro, iPhone11ProMax
    case iPhone12mini, iPhone12
    case iPhone12Pro, iPhone12ProMax
    case iPhone13mini, iPhone13
    case iphone13Pro, iPhone13ProMax
    case iPadFirstGen, iPadSecondGen, iPadThirdGen, iPadFourthGen, iPadFifthGen, iPadSixthGen, iPadSeventhGen, iPadEighthGen
    case iPadAir, iPadAir2, iPadAir3, iPadAir4
    case iPadMini, iPadMini2, iPadMini3, iPadMini4, iPadMini5
    case iPadPro9Inch7, iPadPro10Inch5, iPadPro12Inch9, iPadPro12Inch9SecondGen
    case iPadPro11Inch, iPadPro12Inch9ThirdGen
    case iPadPro11InchSecondGen, iPadPro12Inch9FourthGen
    case iPodTouchFirstGen, iPodTouchSecondGen, iPodTouchThirdGen,
         iPodTouchFourthGen, iPodTouchFifthGen, iPodTouchSixthGen, iPodTouchSeventhGen
    case unknown
}

extension DeviceModel {
    init(identifier: Identifier) {
        switch identifier.type {
        case .iPhone:
            self = DeviceModel.detectIphoneModel(with: identifier)
        case .iPad:
            self = DeviceModel.detectIpadModel(with: identifier)
        case .iPod:
            self = DeviceModel.detectIpodModel(with: identifier)
        default:
            self = .unknown
        }
    }
}

private extension DeviceModel {
    static func detectIphoneModel(with identifier: Identifier) -> DeviceModel {
        guard let major = identifier.version.major,
              let minor = identifier.version.minor,
              identifier.type == .iPhone
        else { return .unknown }

        switch (major, minor) {
        case (3, _): return .iPhone4
        case (4, _): return .iPhone4S
        case (5, 1), (5, 2): return .iPhone5
        case (5, 3), (5, 4): return .iPhone5C
        case (6, _): return .iPhone5S
        case (7, 2): return .iPhone6
        case (7, 1): return .iPhone6Plus
        case (8, 1): return .iPhone6S
        case (8, 2): return .iPhone6SPlus
        case (8, 4): return .iPhoneSE
        case (9, 1), (9, 3): return .iPhone7
        case (9, 2), (9, 4): return .iPhone7Plus
        case (10, 1), (10, 4): return .iPhone8
        case (10, 2), (10, 5): return .iPhone8Plus
        case (10, 3), (10, 6): return .iPhoneX
        case (11, 2): return .iPhoneXS
        case (11, 4), (11, 6): return .iPhoneXSMax
        case (11, 8): return .iPhoneXR
        case (12, 1): return .iPhone11
        case (12, 3): return .iPhone11Pro
        case (12, 5): return .iPhone11ProMax
        case (12, 8): return .iPhoneSE2
        case (13, 1): return .iPhone12mini
        case (13, 2): return .iPhone12
        case (13, 3): return .iPhone11Pro
        case (13, 4): return .iPhone12ProMax
        case (14, 2): return .iphone13Pro
        case (14, 3): return .iPhone13ProMax
        case (14, 4): return .iPhone13mini
        case (14, 5): return .iPhone13
        default: return .unknown
        }
    }
}

private extension DeviceModel {
    static func detectIpadModel(with identifier: Identifier) -> DeviceModel {
        guard let major = identifier.version.major,
              let minor = identifier.version.minor,
              identifier.type == .iPad
        else { return .unknown }

        switch (major, minor) {
        case (1, _): return .iPadFirstGen
        case (2, 1), (2, 2), (2, 3), (2, 4): return .iPadSecondGen
        case (3, 1), (3, 2), (3, 3): return .iPadThirdGen
        case (3, 4), (3, 5), (3, 6): return .iPadFourthGen
        case (6, 11), (6, 12): return .iPadFifthGen
        case (7, 5), (7, 6): return .iPadSixthGen
        case (7, 11), (7, 12): return .iPadSeventhGen
        case (11, 6), (11, 7): return .iPadEighthGen
        case (4, 1), (4, 2), (4, 3): return .iPadAir
        case (5, 3), (5, 4): return .iPadAir2
        case (11, 3), (11, 4): return .iPadAir3
        case (13, 1), (13, 2): return .iPadAir4
        case (2, 5), (2, 6), (2, 7): return .iPadMini
        case (4, 4), (4, 5), (4, 6): return .iPadMini2
        case (4, 7), (4, 8), (4, 9): return .iPadMini3
        case (5, 1), (5, 2): return .iPadMini4
        case (11, 1), (11, 2): return .iPadMini5
        case (6, 3), (6, 4): return .iPadPro9Inch7
        case (7, 3), (7, 4): return .iPadPro10Inch5
        case (8, 1), (8, 2), (8, 3), (8, 4): return .iPadPro11Inch
        case (8, 9), (8, 10): return .iPadPro11InchSecondGen
        case (6, 7), (6, 8): return .iPadPro12Inch9
        case (7, 1), (7, 2): return .iPadPro12Inch9SecondGen
        case (8, 5), (8, 6), (8, 7), (8, 8): return .iPadPro12Inch9ThirdGen
        case (8, 11), (8, 12): return .iPadPro12Inch9FourthGen
        default: return .unknown
        }
    }
}

private extension DeviceModel {
    static func detectIpodModel(with identifier: Identifier) -> DeviceModel {
        guard let major = identifier.version.major,
              let minor = identifier.version.minor,
              identifier.type == .iPod
        else { return .unknown }

        switch (major, minor) {
        case (1, 1): return .iPodTouchFirstGen
        case (2, 1): return .iPodTouchSecondGen
        case (3, 1): return .iPodTouchThirdGen
        case (4, 1): return .iPodTouchFourthGen
        case (5, 1): return .iPodTouchFifthGen
        case (7, 1): return .iPodTouchSixthGen
        case (9, 1): return .iPodTouchSeventhGen
        default: return .unknown
        }
    }
}

public extension DeviceModel {
    var hasNotch: Bool {
        switch self {
        case .iPhoneX, .iPhoneXS, .iPhoneXSMax, .iPhoneXR:
            return true
        case .iPhone11, .iPhone11Pro, .iPhone11ProMax:
            return true
        case .iPhone12mini, .iPhone12, .iPhone12Pro, .iPhone12ProMax:
            return true
        case .iPhone13mini, .iPhone13, .iphone13Pro, .iPhone13ProMax:
            return true
        default:
            return false
        }
    }
}

struct Identifier {
    let type: DeviceFamily
    let version: (major: Int?, minor: Int?)

    init(_ identifier: String) {
        let typeVersionTuple = Identifier.typeVersionComponents(with: identifier)
        type = DeviceFamily(rawValue: typeVersionTuple.type)
        version = (typeVersionTuple.major, typeVersionTuple.minor)
    }
}

extension Identifier {
    struct TypeVersionTuple {
        var type: String
        var major: Int?
        var minor: Int?
    }

    static func typeVersionComponents(with identifierString: String) -> Identifier.TypeVersionTuple {
        let numericCharacters: [String] = (0 ... 9).map { "\($0)" }
        let type = identifierString.prefix(while: { !numericCharacters.contains(String($0)) })
        let version = identifierString.suffix(from: type.endIndex)
            .split(separator: ",")
            .map { Int($0) }
        let major: Int? = !version.isEmpty ? version[0] : nil
        let minor: Int? = version.count > 1 ? version[1] : nil
        return TypeVersionTuple(type: String(type), major: major, minor: minor)
    }
}

extension Identifier: CustomStringConvertible {
    var description: String {
        guard let major = version.major,
              let minor = version.minor
        else { return "unknown" }

        switch type {
        case .iPhone:
            return iphoneStringRepresentation(major: major, minor: minor)
        case .iPad:
            return iPadStringRepresentation(major: major, minor: minor)
        case .iPod:
            return iPodStringRepresentation(major: major, minor: minor)
        case .unknown:
            return "unknown"
        }
    }

    private func iphoneStringRepresentation(major: Int, minor: Int) -> String {
        switch (major, minor) {
        case (1, 1):
            return "iPhone"
        case (1, 2):
            return "iPhone 3G"
        case (2, 1):
            return "iPhone 3GS"
        case (3, 1):
            return "iPhone 4"
        case (3, 2):
            return "iPhone 4 GSM Rev A"
        case (3, 3):
            return "iPhone 4 CDMA"
        case (4, 1):
            return "iPhone 4S"
        case (5, 1):
            return "iPhone 5 GSM+LTE"
        case (5, 2):
            return "iPhone 5 CDMA+LTE"
        case (5, 3):
            return "iPhone 5C (GSM)"
        case (5, 4):
            return "iPhone 5C (Global)"
        case (6, 1):
            return "iPhone 5S (GSM)"
        case (6, 2):
            return "iPhone 5S (Global)"
        case (7, 1):
            return "iPhone 6 Plus"
        case (7, 2):
            return "iPhone 6"
        case (8, 1):
            return "iPhone 6s"
        case (8, 2):
            return "iPhone 6s Plus"
        case (8, 3):
            return "iPhone SE (GSM+CDMA)"
        case (8, 4):
            return "iPhone SE (GSM)"
        case (9, 1):
            return "iPhone 7"
        case (9, 2):
            return "iPhone 7 Plus"
        case (9, 3):
            return "iPhone 7"
        case (9, 4):
            return "iPhone 7 Plus"
        case (10, 1):
            return "iPhone 8"
        case (10, 2):
            return "iPhone 8 Plus"
        case (10, 3):
            return "iPhone X"
        case (10, 4):
            return "iPhone 8"
        case (10, 5):
            return "iPhone 8 Plus"
        case (10, 6):
            return "iPhone X"
        case (11, 2):
            return "iPhone XS"
        case (11, 4):
            return "iPhone XS Max"
        case (11, 6):
            return "iPhone XS Max (China)"
        case (11, 8):
            return "iPhone XR"
        case (12, 1):
            return "iPhone 11"
        case (12, 3):
            return "iPhone 11 Pro"
        case (12, 5):
            return "iPhone 11 Pro Max"
        case (12, 8):
            return "iPhone SE (2nd Gen)"
        case (13, 1):
            return "iPhone 12 mini"
        case (13, 2):
            return "iPhone 12"
        case (13, 3):
            return "iPhone 12 Pro"
        case (13, 4):
            return "iPhone 12 Pro Max"
        case (14, 2):
            return "iPhone 13 Pro"
        case (14, 3):
            return "iPhone 13 Pro Max"
        case (14, 4):
            return "iPhone 13 Mini"
        case (14, 5):
            return "iPhone 13"

        default:
            return "unknown"
        }
    }

    private func iPodStringRepresentation(major: Int, minor: Int) -> String {
        switch (major, minor) {
        case (1, 1):
            return "1st Gen iPod"
        case (2, 1):
            return "2nd Gen iPod"
        case (3, 1):
            return "3rd Gen iPod"
        case (4, 1):
            return "4th Gen iPod"
        case (5, 1):
            return "5th Gen iPod"
        case (7, 1):
            return "6th Gen iPod"
        case (9, 1):
            return "7th Gen iPod"
        default:
            return "unknown"
        }
    }

    private func iPadStringRepresentation(major: Int, minor: Int) -> String {
        switch (major, minor) {
        case (1, 1):
            return "iPad"
        case (1, 2):
            return "iPad 3G"
        case (2, 1):
            return "2nd Gen iPad"
        case (2, 2):
            return "2nd Gen iPad GSM"
        case (2, 3):
            return "2nd Gen iPad CDMA"
        case (2, 4):
            return "2nd Gen iPad New Revision"
        case (2, 5):
            return "iPad mini"
        case (2, 6):
            return "iPad mini GSM+LTE"
        case (2, 7):
            return "iPad mini CDMA+LTE"
        case (3, 1):
            return "3rd Gen iPad"
        case (3, 2):
            return "3rd Gen iPad CDMA"
        case (3, 3):
            return "3rd Gen iPad GSM"
        case (3, 4):
            return "4th Gen iPad"
        case (3, 5):
            return "4th Gen iPad GSM+LTE"
        case (3, 6):
            return "4th Gen iPad CDMA+LTE"
        case (4, 1):
            return "iPad Air (WiFi)"
        case (4, 2):
            return "iPad Air (GSM+CDMA)"
        case (4, 3):
            return "iPad Air (China)"
        case (4, 4):
            return "iPad mini Retina (WiFi)"
        case (4, 5):
            return "iPad mini Retina (GSM+CDMA)"
        case (4, 6):
            return "iPad mini Retina (China)"
        case (4, 7):
            return "iPad mini 3 (WiFi)"
        case (4, 8):
            return "iPad mini 3 (GSM+CDMA)"
        case (4, 9):
            return "iPad mini 3 (China)"
        case (5, 1):
            return "iPad mini 4 (WiFi)"
        case (5, 2):
            return "iPad mini 4 (WiFi+LTE)"
        case (5, 3):
            return "iPad Air 2 (WiFi)"
        case (5, 4):
            return "iPad Air 2 (Cellular)"
        case (6, 3):
            return "iPad Pro (9.7 inch, Wi-Fi)"
        case (6, 4):
            return "iPad Pro (9.7 inch, Wi-Fi+LTE)"
        case (6, 7):
            return "iPad Pro (12.9 inch, Wi-Fi)"
        case (6, 8):
            return "iPad Pro (12.9 inch, Wi-Fi+LTE)"
        case (6, 11):
            return "5th Gen iPad (WiFi)"
        case (6, 12):
            return "5th Gen iPad (Cellular)"
        case (7, 1):
            return "2nd Gen iPad Pro (12.9 inch, Wi-Fi)"
        case (7, 2):
            return "2nd Gen iPad Pro (12.9 inch, Wi-Fi+LTE)"
        case (7, 3):
            return "iPad Pro (10.5 inch, Wi-Fi)"
        case (7, 4):
            return "iPad Pro (10.5 inch, Wi-Fi+LTE)"
        case (7, 5):
            return "6th Gen iPad (WiFi)"
        case (7, 6):
            return "6th Gen iPad (Cellular)"
        case (7, 11):
            return "7th Gen iPad (10.2 inch, WiFi)"
        case (7, 12):
            return "7th Gen iPad (10.2 inch, Cellular)"
        case (8, 1):
            return "iPad Pro (11 inch, Wi-Fi)"
        case (8, 2):
            return "iPad Pro (11 inch, Wi-Fi, 1TB)"
        case (8, 3):
            return "iPad Pro (11 inch, Wi-Fi+LTE)"
        case (8, 4):
            return "iPad Pro (11 inch, Wi-Fi+LTE, 1TB)"
        case (8, 5):
            return "3rd Gen iPad Pro (12.9 inch, Wi-Fi)"
        case (8, 6):
            return "3rd Gen iPad Pro (12.9 inch, Wi-Fi, 1TB)"
        case (8, 7):
            return "3rd Gen iPad Pro (12.9 inch, Wi-Fi+LTE)"
        case (8, 8):
            return "3rd Gen iPad Pro (12.9 inch, Wi-Fi+LTE, 1TB)"
        case (8, 9):
            return "2nd Gen iPad Pro (11 inch, Wi-Fi)"
        case (8, 10):
            return "2nd Gen iPad Pro (11 inch, Wi-Fi+LTE)"
        case (8, 11):
            return "4th Gen iPad Pro (12.9 inch, Wi-Fi)"
        case (8, 12):
            return "4th Gen iPad Pro (12.9 inch, Wi-Fi+LTE)"
        case (11, 1):
            return "5th Gen iPad Mini (Wi-Fi)"
        case (11, 2):
            return "5th Gen iPad Mini (Wi-Fi+LTE)"
        case (11, 3):
            return "3rd Gen iPad Air (Wi-Fi)"
        case (11, 4):
            return "3rd Gen iPad Air (Wi-Fi+LTE)"
        case (13, 1):
            return "4th Gen iPad Air (Wi-Fi)"
        case (13, 2):
            return "4th Gen iPad Air (Wi-Fi+LTE)"
        case (11, 6):
            return "8th Gen iPad (10.2 inch, WiFi)"
        case (11, 7):
            return "8th Gen iPad (10.2 inch, Cellular)"
        default:
            return "unknown"
        }
    }
}

public enum DeviceFamily: String {
    case iPhone
    case iPod
    case iPad
    case unknown

    public init(rawValue: String) {
        switch rawValue {
        case "iPhone":
            self = .iPhone
        case "iPod":
            self = .iPod
        case "iPad":
            self = .iPad
        default:
            self = .unknown
        }
    }
}

public extension DeviceFamily {
    var isSimulator: Bool {
        #if arch(i386) || arch(x86_64)
            return true
        #else
            return false
        #endif
    }
}

public final class UIDeviceComplete<Base> {
    let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol UIDeviceCompleteCompatible {
    associatedtype CompatibleType

    var dc: CompatibleType { get }
}

public extension UIDeviceCompleteCompatible {
    var dc: UIDeviceComplete<Self> {
        UIDeviceComplete(self)
    }
}

extension UIDevice: UIDeviceCompleteCompatible {}

enum System {
    static var name: String? {
        var systemInfo = utsname()
        uname(&systemInfo)
        let encoding: UInt = String.Encoding.ascii.rawValue
        if let string = NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: encoding) {
            let identifier = (string as String).components(separatedBy: "\0").first
            if identifier == "x86_64" || identifier == "i386" {
                return ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"]
            }
            return identifier
        }
        return nil
    }
}

public extension UIDeviceComplete where Base == UIDevice {
    private var identifier: Identifier? {
        return System.name.flatMap {
            Identifier($0)
        }
    }

    var deviceFamily: DeviceFamily {
        return identifier.flatMap { $0.type } ?? .unknown
    }

    var deviceModel: DeviceModel {
        return identifier.flatMap { DeviceModel(identifier: $0) } ?? .unknown
    }

    var commonDeviceName: String {
        return identifier?.description ?? "unknown"
    }
}

public extension UIDeviceComplete where Base == UIDevice {
    var screenSize: Screen {
        let scale: Double = Double(UIScreen.main.scale)
        let width: Double = Double(UIScreen.main.bounds.width)
        let height: Double = Double(UIScreen.main.bounds.height)
        return Screen(width: width, height: height, scale: scale)
    }
}

public struct Screen {
    init(width: Double, height: Double, scale: Double) {
        self.width = width
        self.height = height
        self.scale = scale
    }

    public let width: Double
    public let height: Double
    public let scale: Double

    public var adjustedScale: Double {
        return 1.0 / scale
    }
}

extension Screen {
    public var sizeInches: Double? {
        switch (height, scale) {
        case (480, _): return 3.5
        case (568, _): return 4.0
        case (667, 3.0), (736, _): return 5.5
        case (667, 1.0), (667, 2.0): return 4.7
        case (812, 3.0): return 5.8
        case (896, 2.0): return 6.1
        case (896, 3.0): return 6.5
        case (1024, _): return ipadSize1024()
        case (1080, _): return 10.2
        case (1112, _): return 10.5
        case (1180, _): return 10.9
        case (1194, _): return 11.0
        case (1366, _): return 12.9
        default: return nil
        }
    }

    func ipadSize1024() -> Double {
        let deviceModel = UIDevice().dc.deviceModel
        switch deviceModel {
        case .iPadMini, .iPadMini2, .iPadMini3, .iPadMini4, .iPadMini5: return 7.9
        case .iPadPro10Inch5: return 10.5
        default: return 9.7
        }
    }
}

public extension Screen {
    var aspectRatio: String? {
        switch (height, scale) {
        case (480, _): return "3:2"
        case (568, _), (667, 3.0), (736, _), (667, 1.0), (667, 2.0): return "16:9"
        case (812, 3.0), (896, 2.0), (896, 3.0): return "19.5:9"
        case (1024, _), (1112, _), (1366, _), (1080, _): return "4:3"
        default: return nil
        }
    }
}
