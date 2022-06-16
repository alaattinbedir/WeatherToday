//
//  AlertModel.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import ObjectMapper
import UIKit

@objc
class AlertModel: NSObject, Mappable {
    @objc var title: String?
    @objc var header: String?
    @objc var message: String?
    @objc var code: Int = 0
    @objc var field: String?
    @objc var extraFields: [String: Any] = [:]
    var icon: UIImage?
    var textAlignment: NSTextAlignment = .center
    var textFont: UIFont?
    var buttons: [AlertButtonTag] = [.ok]
    var status: StatusType = .unknown {
        didSet { icon = icon ?? status.icon }
    }

    var enableCloseButton: Bool = false
    var isHtml: Bool?

    required init?(map _: Map) {
        // Intentionally unimplemented
    }

    override init() {
        // Intentionally unimplemented
    }

    convenience init(title: ResourceKey? = nil,
                     header: ResourceKey? = nil,
                     message: ResourceKey? = nil,
                     icon: UIImage? = nil,
                     textAlignment: NSTextAlignment = .center,
                     textFont: UIFont? = nil,
                     buttons: [AlertButtonTag] = [.ok],
                     code: Int = 0,
                     enableCloseButton: Bool = false,
                     isHtml: Bool = false) {
        self.init(title: title?.value,
                  header: header?.value,
                  message: message?.value,
                  icon: icon,
                  textAlignment: textAlignment,
                  textFont: textFont,
                  buttons: buttons,
                  code: code,
                  enableCloseButton: enableCloseButton,
                  isHtml: isHtml)
    }

    convenience init(title: String? = nil,
                     header: String? = nil,
                     message: String? = nil,
                     icon: UIImage? = nil,
                     textAlignment: NSTextAlignment = .center,
                     textFont: UIFont? = nil,
                     buttons: [AlertButtonTag] = [.ok],
                     code: Int = 0,
                     enableCloseButton: Bool = false,
                     isHtml: Bool = false) {
        self.init()
        self.title = title
        self.header = header
        self.message = message
        self.textAlignment = textAlignment
        self.textFont = textFont
        self.icon = icon
        self.buttons = buttons
        self.code = code
        self.enableCloseButton = enableCloseButton
        self.isHtml = isHtml
    }

    func mapping(map: Map) {
        title <- map["Title"]
        header <- map["Header"]
        message <- map["Message"]
        code <- map["Code"]
        field <- map["Field"]
        extraFields <- map["ExtraFields"]

        buttons <- (map["Buttons"], TransformOf<[AlertButtonTag], [String]>(fromJSON: { value in
            guard let value = value else { return [.ok] }
            return value.map { AlertButtonTag.generic($0) }
        }, toJSON: { value in
            guard let value = value else { return [] }
            return value.map { $0.identifier.rawValue }
        }))
        if buttons.isEmpty {
            buttons = [.ok]
        }
    }

    func with(message: String) -> AlertModel {
        self.message = message
        return self
    }
}

class FieldAlertModel: Equatable {
    var fieldAlert: FieldAlert
    var message: String

    init(field: String, message: String) {
        fieldAlert = FieldAlert(rawValue: field) ?? .unknown
        self.message = message
    }

    static func == (lhs: FieldAlertModel, rhs: FieldAlertModel) -> Bool {
        return lhs.message == rhs.message
    }
}
