//
//  AppConstants.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
import UIKit

struct Key {
    #if APP_STORE
        static let appGroupId = "group.mobildeniz"
    #else
        static let appGroupId = "group.mobildeniz.internal"
    #endif

    enum Charset {
        static let loginUsernameField =
            "0123456789ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZQWXabcçdefgğhıijklmnoöprsştuüvyzqwx@+*/?!,;|:#'\"()&[]·_<>.•^-"
        static let usernameField =
            "0123456789ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZQWXabcçdefgğhıijklmnoöprsştuüvyzqwx@ +*/?!,;|:#'\"()&[]·_<>.•^-"
        static let recieverName = "@+*/?!,;|:#'\"()&[]·_<>.•^-%0123456789"
        static let recieverNameOnly =
            "0123456789ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZQWXabcçdefgğhıijklmnoöprsştuüvyzqwx.,-_/+& "
        static let explanation = "0123456789ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZQWXabcçdefgğhıijklmnoöprsştuüvyzqwx., "
        static let multiplierField = "0123456789,"
        static let cardField = "0123456789"
        static let numeric = "0123456789"
        static let digitsAndSpace = "0123456789 "
        static let alphaNumeric = "0123456789ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZQWXabcçdefgğhıijklmnoöprsştuüvyzqwx"
        static let subscriberNumber = "0123456789ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZQWXabcçdefgğhıijklmnoöprsştuüvyzqwx.,-"
        static let swiftMessageReferenceNoCharWhiteList =
            "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/–?:().,‘'+- "
    }

    enum Keychain {
        static let serviceName = "com.denizbank.MobilDeniz.keychainservice"
        static let uniqueDeviceId = "UniqueDeviceID_Ver2"
        static let transactionNotificationSound = "transactionNotificationSoundIsPlay"
        static let userId = "userId"

        #if DEBUG || INTERNAL
            static let analyticsToastMessageShow = "analyticsToastMessageShow"
            static let disableMsisdn = "disableMsisdn"
            static let lastSessionInternal = "lastSessionInternal"
        #endif
    }
}

enum TimeIntervals: TimeInterval {
    case day = 86400
    case week = 691_200
    case month = 2_592_000
}
