//
//  Localizable.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Foundation

enum Localizable {

    case error,
         highlights,
         matches,
         okMessage,
         previous,
         search,
         upcoming

    var localized: String {
        switch self {
        case .error:
            return "ERROR".localize()
        case .highlights:
            return "HIGHLIGHTS".localize()
        case .matches:
            return "MATCHES".localize()
        case .okMessage:
            return "OK".localize()
        case .previous:
            return "PREVIOUS".localize()
        case .search:
            return "SEARCH".localize()
        case .upcoming:
            return "UPCOMING".localize()
        }
    }
}

// MARK: - Localize
fileprivate extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }

    func localize(with arguments: [CVarArg]) -> String {
        return String(format: self.localize(), arguments: arguments)
    }
}
