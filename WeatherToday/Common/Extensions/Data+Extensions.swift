//
//  Data+Extensions.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation

extension Data {
    func savePdfFile(with fileName: String?) -> String? {
        guard let fileName = fileName else {
            return nil
        }

        let filePath = "\(NSTemporaryDirectory())" + fileName + ".pdf"

        do {
            try write(to: URL(fileURLWithPath: filePath), options: .atomic)
        } catch {
            return nil
        }

        return filePath
    }

    struct HexEncodingOptions: OptionSet {
        public let rawValue: Int
        public static let upperCase = HexEncodingOptions(rawValue: 1 << 0)

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return map { String(format: format, $0) }.joined()
    }
}
