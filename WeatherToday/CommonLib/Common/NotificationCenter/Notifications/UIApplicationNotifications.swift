//
//  UIApplicationNotifications.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
import UIKit

public enum UIApplicationNotifications {
    public class willEnterForeground: WhaleNotifiable {
        public typealias ObservedValueType = String

        public static var notificationName: NSNotification.Name = UIApplication.willEnterForegroundNotification

        public static func decode(notification _: Notification) -> String? {
            return UIApplication.willEnterForegroundNotification.rawValue
        }
    }

    public class willTerminate: WhaleNotifiable {
        public typealias ObservedValueType = String

        public static var notificationName: NSNotification.Name = UIApplication.willTerminateNotification

        public static func decode(notification _: Notification) -> String? {
            return UIApplication.willTerminateNotification.rawValue
        }
    }

    public class didBecomeActive: WhaleNotifiable {
        public typealias ObservedValueType = String

        public static var notificationName: NSNotification.Name = UIApplication.didBecomeActiveNotification

        public static func decode(notification _: Notification) -> String? {
            return UIApplication.didBecomeActiveNotification.rawValue
        }
    }

    public class didEnterBackground: WhaleNotifiable {
        public typealias ObservedValueType = String

        public static var notificationName: NSNotification.Name = UIApplication.didEnterBackgroundNotification

        public static func decode(notification _: Notification) -> String? {
            return UIApplication.didEnterBackgroundNotification.rawValue
        }
    }
}
