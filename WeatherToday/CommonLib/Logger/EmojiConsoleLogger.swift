//
//  EmojiConsoleLogger.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation


public class EmojiConsoleLogger: LoggerType {
    public init() { /* Empty */ }

    public func w(tag: String, _ items: Any..., error _: Error?) {
        print("")
        print("")
        print("")
        print("")
        print("⚠️------------------------------------------------------------------⚠️")
        print("⚠️")
        log(tag, items)
        print("⚠️")
        print("⚠️------------------------------------------------------------------⚠️")
        print("")
        print("")
    }

    public func e(tag: String, _ items: Any..., error _: Error) {
        print("")
        print("")
        print("")
        print("")
        print("❌------------------------------------------------------------------❌")
        print("❌")
        log(tag, items)
        print("❌")
        print("❌------------------------------------------------------------------❌")
        print("")
        print("")
    }

    public func i(tag: String, _ items: Any...) {
        print("")
        print("")
        print("")
        print("")
        print("ℹ️------------------------------------------------------------------ℹ️")
        print("ℹ️")
        log(tag, items)
        print("ℹ️")
        print("ℹ️------------------------------------------------------------------ℹ️")
        print("")
        print("")
    }

    public func v(tag: String, _ items: Any...) {
        print("")
        print("")
        print("")
        print("")
        print("🍏------------------------------------------------------------------🍏")
        print("🍏")
        log(tag, items)
        print("🍏")
        print("🍏------------------------------------------------------------------🍏")
        print("")
        print("")
    }

    public func analytic(event:LoggerEvent) {
        var paramStr = "no-param"
        if let params = event.params {
            paramStr = params.reduce("") { $0 + " " + $1.key + ": " + String(describing: $1.value) }
        }

        print("")
        print("")
        print("")
        print("")
        print("🕷️------------------------------------------------------------------🕷️")
        print("🕷️")
        log("analytic", event.event, paramStr)
        print("🕷️")
        print("🕷️------------------------------------------------------------------🕷️")
        print("")
        print("")
    }

    private func log(_ items: Any...) {
        DispatchQueue.global().async {
            print(items.flatten().compactMap { $0 }.toStringForPrint(seperator: ", ")
                .replacingOccurrences(of: "\\n", with: "\n")
                .replacingOccurrences(of: "\\\"", with: "\"")
                .replacingOccurrences(of: "\\/", with: "/"))
        }
    }
}

private extension Array {
    func flatten() -> [Element] {
        return Array.flatten(0, self)
    }

    static func flatten<Element>(_ index: Int, _ toFlat: [Element]) -> [Element] {
        guard index < toFlat.count else { return [] }

        var flatten: [Element] = []

        if let itemArr = toFlat[index] as? [Element] {
            flatten += itemArr.flatten()
        } else {
            flatten.append(toFlat[index])
        }

        return flatten + Array.flatten(index + 1, toFlat)
    }
}
