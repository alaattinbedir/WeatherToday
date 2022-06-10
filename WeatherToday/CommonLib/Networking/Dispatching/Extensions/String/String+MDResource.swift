//
//  String+MDResource.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
extension String {
    func resource(ifNillReturnResourceKey: Bool = true) -> String {
        #if TESTING
            return self
        #else
            if let resource = AppStringResources.shared.findResource(key: trimmingCharacters(in: .whitespacesAndNewlines),
                                                                     searchInLocal: ifNillReturnResourceKey) as? String {
                if resource == " " {
                    return ""
                }

                if resource.contains("\\n") {
                    return resource.replacingOccurrences(of: "\\n", with: "\n")
                }
                return resource
            } else if ifNillReturnResourceKey {
                return self
            } else {
                return ""
            }
        #endif
    }

    func resource(params: String...) -> String {
        var resourceStr = resource()
        resourceStr = resourceStr.replaceParamsWithCurlyBrackets(params)
        return resourceStr
    }

    func replaceParamsWithCurlyBrackets(_ params: String...) -> String {
        return replaceParamsWithCurlyBrackets(params)
    }

    func replaceParamsWithCurlyBrackets(_ params: [String]) -> String {
        var resourceStr = self
        guard resourceStr.count > 0 else { return resourceStr }
        guard resourceStr.contains("{"), resourceStr.contains("}") else { return resourceStr }

        var paramIndex = 0
        for param in params {
            let searchParamPattern = "{\(paramIndex)}"
            paramIndex += 1
            guard resourceStr.contains(searchParamPattern) else { continue }
            resourceStr = resourceStr.replacingOccurrences(of: searchParamPattern, with: param)
        }

        return resourceStr
    }

    // MARK: Currency

    func convertToUnitCode() -> String {
        #if TESTING
            return self
        #else
            var unitCode = "Currencies.\(self).UnitCode".resource(ifNillReturnResourceKey: false)
            if unitCode.count == 0 {
                unitCode = self
            }
            return unitCode
        #endif
    }

    func convertToReadableCode() -> String {
        #if TESTING
            return self
        #else
            var unitCode = "Assets.ConvertCurrencyTitle\(self)".resource(ifNillReturnResourceKey: false)

            if unitCode.count == 0 {
                unitCode = self
            }
            return unitCode
        #endif
    }

    func currencyConvertToName() -> String {
        #if TESTING
            return self
        #else
            var unitCode = "Currencies.\(self).Name".resource(ifNillReturnResourceKey: false)
            if unitCode.count == 0 {
                unitCode = self
            }
            return unitCode
        #endif
    }

    func convertToCurrency() -> String {
        #if TESTING
            return self
        #else
            var unitCode = self
            if unitCode == "TRY" {
                unitCode = "Currencies.\(self).UnitCode".resource(ifNillReturnResourceKey: false)
            }
            if unitCode.count == 0 {
                unitCode = self
            }
            return unitCode
        #endif
    }
}
