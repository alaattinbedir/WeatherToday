//
//  KeyboardStatusNotifications.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
import UIKit

public enum KeyboardNotifications {
    public class KeyboardNotification {
        public let animationCurveUserInfoKey: Int?
        public let animationDurationUserInfoKey: Float?
        public let frameBeginUserInfoKey: CGRect?
        public let frameEndUserInfoKey: CGRect?
        public let isLocalUserInfoKey: Int?

        init(
            animationCurveUserInfoKey: Int? = nil,
            animationDurationUserInfoKey: Float? = nil,
            frameBeginUserInfoKey: CGRect? = nil,
            frameEndUserInfoKey: CGRect? = nil,
            isLocalUserInfoKey: Int? = nil
        ) {
            self.animationCurveUserInfoKey = animationCurveUserInfoKey
            self.animationDurationUserInfoKey = animationDurationUserInfoKey
            self.frameBeginUserInfoKey = frameBeginUserInfoKey
            self.frameEndUserInfoKey = frameEndUserInfoKey
            self.isLocalUserInfoKey = isLocalUserInfoKey
        }
    }

    public class willShow: KeyboardNotification, WhaleNotifiable {
        public typealias ObservedValueType = KeyboardNotification

        public static var notificationName: NSNotification.Name = UIResponder.keyboardWillShowNotification

        public static func decode(notification: Notification) -> KeyboardNotification? {
            return KeyboardNotifications.notificationToKeyboardDecoder(notification)
        }
    }

    public class didShow: KeyboardNotification, WhaleNotifiable {
        public typealias ObservedValueType = KeyboardNotification

        public static var notificationName: NSNotification.Name = UIResponder.keyboardDidShowNotification

        public static func decode(notification: Notification) -> KeyboardNotification? {
            return KeyboardNotifications.notificationToKeyboardDecoder(notification)
        }
    }

    public class willHide: KeyboardNotification, WhaleNotifiable {
        public typealias ObservedValueType = KeyboardNotification

        public static var notificationName: NSNotification.Name = UIResponder.keyboardWillHideNotification

        public static func decode(notification: Notification) -> KeyboardNotification? {
            return KeyboardNotifications.notificationToKeyboardDecoder(notification)
        }
    }

    public class didHide: KeyboardNotification, WhaleNotifiable {
        public typealias ObservedValueType = KeyboardNotification

        public static var notificationName: NSNotification.Name = UIResponder.keyboardDidHideNotification

        public static func decode(notification: Notification) -> KeyboardNotification? {
            return KeyboardNotifications.notificationToKeyboardDecoder(notification)
        }
    }

    public class didChangeFrame: KeyboardNotification, WhaleNotifiable {
        public typealias ObservedValueType = KeyboardNotification

        public static var notificationName: NSNotification.Name = UIResponder.keyboardDidChangeFrameNotification

        public static func decode(notification: Notification) -> KeyboardNotification? {
            return KeyboardNotifications.notificationToKeyboardDecoder(notification)
        }
    }

    public class willChangeFrame: KeyboardNotification, WhaleNotifiable {
        public typealias ObservedValueType = KeyboardNotification

        public static var notificationName: NSNotification.Name = UIResponder.keyboardWillChangeFrameNotification

        public static func decode(notification: Notification) -> KeyboardNotification? {
            return KeyboardNotifications.notificationToKeyboardDecoder(notification)
        }
    }

    fileprivate static func notificationToKeyboardDecoder(_ notification: Notification) -> KeyboardNotification {
        guard let userInfo = notification.userInfo else {
            return KeyboardNotification()
        }

        let keyboardData =
            KeyboardNotification(animationCurveUserInfoKey: (userInfo[UIResponder
                    .keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue,
            animationDurationUserInfoKey: (userInfo[UIResponder
                    .keyboardAnimationDurationUserInfoKey] as? NSNumber)?.floatValue,
            frameBeginUserInfoKey: (userInfo[UIResponder
                    .keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            frameEndUserInfoKey: (userInfo[UIResponder
                    .keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            isLocalUserInfoKey: (userInfo[UIResponder
                    .keyboardIsLocalUserInfoKey] as? NSNumber)?.intValue)

        return keyboardData
    }
}
