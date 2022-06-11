//
//  MimeType.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 8.06.2022.
//

import Foundation

/** it is used to check file extention type when communicating. */
public enum MimeType: String {
    case applicationJson = "application/json"
    case textHtml = "text/html"
    case applicationPdf = "application/pdf"
    case formUrlEncoded = "application/x-www-form-urlencoded; charset=utf-8"
    case imagePNG = "image/png"
    case empty = ""
    case base64ForHTML = "base64"
}
