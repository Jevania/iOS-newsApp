//
//  NSMutableAttributedString+Extension.swift
//  mnews
//
//  Created by jevania on 15/05/24.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    static func attributedText(icon: String, text: String) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString()
        let attachment = NSTextAttachment(image: UIImage(systemName: icon)!)
        let attachmentString = NSAttributedString(attachment: attachment)
        attributedText.append(attachmentString)
        attributedText.append(NSAttributedString(string: " \(text)"))
        return attributedText
    }
}
