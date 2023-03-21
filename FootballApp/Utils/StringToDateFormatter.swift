//
//  StringToDateFormatter.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Foundation

struct StringToDateFormatter {

    // MARK: - Properties
    private static let inputFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()

    private static let outputFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy hh:mm a"
        formatter.locale = Locale.current
        return formatter
    }()

    // MARK: - Private initializer
    private init() { }

    // MARK: - Methods
    static func dateTimeFormatted(from string: String) -> String? {
        guard let date = inputFormatter.date(from: string) else { return nil }
        return outputFormatter.string(from: date)
    }
}
