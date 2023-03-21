//
//  File.swift
//  
//
//  Created by Luis Gustavo on 21/03/23.
//

import Foundation

enum Localizable {

    case dataMustExist,
         notHttpUrlResponse,
         unableToCreateQueryParameters,
         unableToCreateUrl,
         unknownStatusCode

    var localized: String {
        switch self {
        case .dataMustExist:
            return "DATA_MUST_EXIST".localize()
        case .notHttpUrlResponse:
            return "NOT_HTTP_URL_RESPONSE".localize()
        case .unableToCreateQueryParameters:
            return "UNABLE_TO_CREATE_QUERY_PARAMETERS".localize()
        case .unableToCreateUrl:
            return "UNABLE_TO_CREATE_URL".localize()
        case .unknownStatusCode:
            return "UNKNOWN_STATUS_CODE".localize()
        }
    }
}

// MARK: - Localize
fileprivate extension String {
    func localize() -> String {
        NSLocalizedString(self, bundle: .module, comment: "")
    }

    func localize(with arguments: [CVarArg]) -> String {
        String(format: localize(), arguments: arguments)
    }
}
