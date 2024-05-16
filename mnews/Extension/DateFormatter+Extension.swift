//
//  DateFormatter+Extension.swift
//  mnews
//
//  Created by jevania on 15/05/24.
//

import Foundation

extension DateFormatter {
    static func formattedDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "dd MMM, yyyy"
            return displayFormatter.string(from: date)
        }
        return "15 May, 2024" //nil
    }
}
