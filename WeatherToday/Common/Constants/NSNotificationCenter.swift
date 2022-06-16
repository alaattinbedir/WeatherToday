//
//  NSNotificationCenter.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
import UIKit

extension NSNotification.Name {
    static let loginWillComplete = Notification.Name("LoginWillComplete")
    static let loginDidComplete = Notification.Name("LoginDidComplete")
    static let logoutDidComplete = Notification.Name("LogoutDidComplete")
    static let hardLogoutDidComplete = Notification.Name("HardLogoutDidComplete")
    static let languageDidChange = Notification.Name("LanguageDidChange")
    static let campaignUpdated = Notification.Name("CampaignUpdated")
    static let sendEvent = Notification.Name("SendEvent")
    static let deviceOrientation = UIDevice.orientationDidChangeNotification
    static let personalPageCardSelected = Notification.Name("PersonalPageCardSelected")
    static let tabChanged = Notification.Name("TabChanged")
    static let hasMainPageShown = Notification.Name("HasMainPageShown")
    static let pushDidReceive = Notification.Name("PushDidReceive")
    static let applicationDidBecomeActive = Notification.Name("applicationDidBecomeActive")
    static let networkReachable = Notification.Name("NetworkReachable")
    static let interrupterWillClosed = Notification.Name("InterrupterWillClosed")
    static let interrupterClosed = Notification.Name("CloseInterrupter")
    static let chatbotQuickAction = Notification.Name("chatbotQuickAction")
    static let showLogOffAlert = Notification.Name("ShowLogOffAlert")
}

