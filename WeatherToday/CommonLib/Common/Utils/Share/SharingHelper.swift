//
//  SharingHelper.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
import UIKit

public class SharingHelper {
    private static let excludedActivityTypes: [UIActivity.ActivityType] =
        [.assignToContact,
         UIActivity
             .ActivityType("com.apple.NanoTimeKitCompanion.CreateWatchFace")]

    public class func share(from: UIViewController?, text: String, _ dismissed: (() -> Void)? = nil) {
        SharingHelper.share(from: from, texts: [text], dismissed)
    }

    public class func share(from: UIViewController?, texts: [String], _ dismissed: (() -> Void)? = nil) {
        SharingHelper.share(from: from, texts: texts, excludedActivityTypes: excludedActivityTypes, dismissed)
    }

    public class func share(from: UIViewController?, texts: [String],
                            excludedActivityTypes: [UIActivity.ActivityType]?, _ dismissed: (() -> Void)? = nil) {
        let textToShare = texts
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = from?.view
        activityViewController.excludedActivityTypes = excludedActivityTypes
        activityViewController.completionWithItemsHandler = { (_, _: Bool, _: [Any]?, _: Error?) in
            dismissed?()
        }
        from?.present(activityViewController, animated: true, completion: nil)
    }

    public class func share(from: UIViewController?, image: UIImage) {
        SharingHelper.share(from: from, image: image, excludedActivityTypes: excludedActivityTypes)
    }

    public class func share(from: UIViewController?, image: UIImage,
                            excludedActivityTypes: [UIActivity.ActivityType]?) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = from?.view
        activityViewController.excludedActivityTypes = excludedActivityTypes
        from?.present(activityViewController, animated: true, completion: nil)
    }

    public class func share(from: UIViewController?, pdfData: Data, pdfName: String) {
        var name = pdfName
        if !name.hasSuffix(".pdf") {
            name += ".pdf"
        }
        let activityViewController = UIActivityViewController(activityItems: [pdfName, pdfData],
                                                              applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = from?.view
        from?.present(activityViewController, animated: true, completion: nil)
    }

    public class func share(from: UIViewController?, data: Data, fileName: String, fileExtension: String) {
        var name = fileName
        if !name.hasSuffix(fileExtension) {
            name += ".\(fileExtension)"
        }
        guard let path = AppDirectories.temp.buildFullPath(forFileName: name) else { return }
        guard let isSuccess = try? AppFileManipulation.writeFile(data: data, to: AppDirectories.temp, withName: name), isSuccess else { return }

        let activityViewController = UIActivityViewController(activityItems: [path],
                                                              applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = from?.view
        from?.present(activityViewController, animated: true, completion: nil)
    }
}
