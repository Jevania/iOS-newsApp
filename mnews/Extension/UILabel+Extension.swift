//
//  UILabel+Extension.swift.swift
//  mnews
//
//  Created by jevania on 15/05/24.
//

import Foundation
import UIKit

extension UILabel {
    func configure(withText text: String?, textColor: UIColor, size: CGFloat, weight: UIFont.Weight, alignment: NSTextAlignment) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
        self.textColor = textColor
        self.text = text
        self.textAlignment = alignment
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
    }
}
