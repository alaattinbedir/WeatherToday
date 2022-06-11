//
//  DateFormat.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public enum DateFormat: String {
    case ddMMyyyyWithSlash = "dd/MM/yyyy"
    case yyyyMMddWithSlash = "yyyy/MM/dd"
    case ddMMyyyyWithDot = "dd.MM.yyyy"
    case ddMMyyyyWithoutDot = "ddMMyyyy"
    case mmDDyyyyWithSlash = "MM/dd/yyyy"
    case ddMMyyyyHHmmWithSlash = "dd/MM/yyyy HH:mm"
    case ddMMyyyyHHmmWithSlashAndHyphenSeperatedForHour = "dd/MM/yyyy - HH:mm"
    case ddMMyyWithSlash = "dd/MM/yy"
    case yyyyMMddWithMinus = "yyyy-MM-dd"
    case ddMMyyyyWithMinus = "dd-MM-yyyy"
    case yyyyMMddWithoutSpecialChar = "yyyyMMdd"
    case yyyyMMddWithDot = "yyyy.MM.dd"
    case yyyyMMWithDot = "yyyy.MM"
    case MMyyyyWithoutSpecialChar = "MMyyyy"
    case yyyySlashMonthName = "yyyy-MMMM"
    case MMMMyyyyWithSlash = "MMMM/yyyy"
    case MMyyyyWithSlash = "MM/yyyy"
    case dd
    case yyyy
    case MMMM
    case MM
    case hhmm = "HH:mm"
    case gitiso = "YYYY-MM-DD hh:mm:ss Z"
    case HHmmEEEE = "HH:mm EEEE"
    case serviceResponseFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
    case serviceRequestFormat = "yyyy-MM-dd'T'HH:mm:ss"
    case ddMMMMyyyyWithSpace = "dd MMMM yyyy"
    case ddMMMyyyEEEEWithSpace = "dd MMMM yyyy EEEE"
}
