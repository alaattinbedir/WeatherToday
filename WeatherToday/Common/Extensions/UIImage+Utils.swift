//
//  UIImage+Utils.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import UIKit

extension UIImage {
    func toBase64() -> String {
        if let imageData = jpegData(compressionQuality: 0.6) {
            return imageData.base64EncodedString()
        }
        return ""
    }

    func with(size newSize: CGFloat) -> UIImage {
        let scale = newSize / size.width
        let newHeight = size.height * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newSize, height: newHeight), false, UIScreen.main.scale)
        draw(in: CGRect(x: 0, y: 0, width: newSize, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }

    func maskRoundedImage() -> UIImage? {
        return maskRoundedImage(radius: size.width * 0.5)
    }

    func maskRoundedImage(radius: CGFloat) -> UIImage? {
        let imageView = UIImageView(image: self)
        let layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = radius
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, UIScreen.main.scale)

        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return roundedImage
        }
        return nil
    }

    func masked(with image: UIImage) -> UIImage? {
        guard let maskRef = image.cgImage, let imageRef = cgImage else { return nil }
        guard let dataProvider = maskRef.dataProvider else { return nil }

        if let imageMask = CGImage(maskWidth: maskRef.width,
                                   height: maskRef.height,
                                   bitsPerComponent: maskRef.bitsPerComponent,
                                   bitsPerPixel: maskRef.bitsPerPixel,
                                   bytesPerRow: maskRef.bytesPerRow,
                                   provider: dataProvider,
                                   decode: nil,
                                   shouldInterpolate: true), let maskedRef = imageRef.masking(imageMask) {
            return UIImage(cgImage: maskedRef).with(size: image.size.width)
        }
        return nil
    }

    func drawText(_ text: String,
                  at point: CGPoint,
                  color: UIColor,
                  font: UIFont) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let textFontAttributes = [NSAttributedString.Key.font: font,
                                  NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                  NSAttributedString.Key.foregroundColor: color] as [NSAttributedString.Key: Any]
        draw(in: CGRect(origin: CGPoint.zero, size: size))

        let rect = CGRect(origin: point, size: size)
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero,
                             size: size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        context.rotate(by: CGFloat(radians))

        draw(in: CGRect(x: -size.width / 2,
                        y: -size.height / 2,
                        width: size.width,
                        height: size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
