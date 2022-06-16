//
//  String+UIUtils.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Atributika
import TextAttributes

extension String {

    var underlined: NSMutableAttributedString {
        let attriburedString = NSMutableAttributedString(string: self)
        attriburedString.textAttributes = TextAttributes().underlineStyle(.single)
        return attriburedString
    }

    func underlined(color: UIColor) -> NSMutableAttributedString {
        let attriburedString = NSMutableAttributedString(string: self)
        attriburedString.textAttributes = TextAttributes().underlineStyle(.single)
        attriburedString.textAttributes = TextAttributes().underlineColor(color)
        return attriburedString
    }

    func letterSpacing(_ letterSpacing: CGFloat) -> NSMutableAttributedString {
        let attriburedString = NSMutableAttributedString(string: self)
        attriburedString.textAttributes = TextAttributes().kern(letterSpacing)
        return attriburedString
    }

    func lineSpacing(_ lineSpacing: CGFloat) -> NSMutableAttributedString {
        let attriburedString = NSMutableAttributedString(string: self)
        attriburedString.textAttributes = TextAttributes().lineSpacing(lineSpacing)
        return attriburedString
    }

    func alignment(_ alignment: NSTextAlignment) -> NSMutableAttributedString {
        let attriburedString = NSMutableAttributedString(string: self)
        attriburedString.textAttributes = TextAttributes().alignment(alignment)
        return attriburedString
    }

    func font(_ font: UIFont) -> NSMutableAttributedString {
        let attriburedString = NSMutableAttributedString(string: self)
        attriburedString.textAttributes = TextAttributes().font(font)
        return attriburedString
    }

    func image() -> UIImage {
        return #imageLiteral(resourceName: self)
    }

    func toImage() -> UIImage? {
        if let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return UIImage(data: imageData)
        }
        return nil
    }

    func size(for font: UIFont) -> CGSize {
        return size(withAttributes: [NSAttributedString.Key.font: font])
    }

    func range(in string: String) -> NSRange {
        return (string as NSString).range(of: self)
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                       options: .usesLineFragmentOrigin,
                                       attributes: [NSAttributedString.Key.font: font],
                                       context: nil)
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                       options: .usesLineFragmentOrigin,
                                       attributes: [NSAttributedString.Key.font: font],
                                       context: nil)
        return ceil(boundingBox.width)
    }

}

private enum TextAttributesAssociatedKeys {
    static var textAttributes: UInt8 = 0
}

extension NSMutableAttributedString {
    func range(in string: String) -> NSRange {
        return (string as NSString).range(of: self.string)
    }

    var textAttributes: TextAttributes {
        get {
            guard let value = objc_getAssociatedObject(self, &TextAttributesAssociatedKeys.textAttributes)
                    as? TextAttributes else {
                return TextAttributes()
            }
            return value
        }
        set {
            objc_setAssociatedObject(self,
                                     &TextAttributesAssociatedKeys.textAttributes,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setAttributes(newValue)
        }
    }

    func underlined(_ range: NSRange? = nil) -> NSMutableAttributedString {
        let attributeRange = range ?? NSRange(location: 0, length: string.count)
        setAttributes(textAttributes.underlineStyle(.single), range: attributeRange)
        return self
    }

    func letterSpacing(_ letterSpacing: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        let attributeRange = range ?? NSRange(location: 0, length: string.count)
        setAttributes(textAttributes.kern(letterSpacing), range: attributeRange)
        return self
    }

    func lineSpacing(_ lineSpacing: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        let attributeRange = range ?? NSRange(location: 0, length: string.count)
        setAttributes(textAttributes.lineSpacing(lineSpacing), range: attributeRange)
        return self
    }

    func alignment(_ alignment: NSTextAlignment, range: NSRange? = nil) -> NSMutableAttributedString {
        let attributeRange = range ?? NSRange(location: 0, length: string.count)
        setAttributes(textAttributes.alignment(alignment), range: attributeRange)
        return self
    }

    func font(_ font: UIFont, range: NSRange? = nil) -> NSMutableAttributedString {
        let attributeRange = range ?? NSRange(location: 0, length: string.count)
        setAttributes(textAttributes.font(font), range: attributeRange)
        return self
    }

    func centered(_ range: NSRange? = nil) -> NSMutableAttributedString {
        let attributeRange = range ?? NSRange(location: 0, length: string.count)
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        addAttributes(textAttributes.paragraphStyle(style), range: attributeRange)
        return self
    }
}
