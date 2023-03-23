//
//  VideoManagerError.swift
//  FootballApp
//
//  Created by Luis Gustavo on 23/03/23.
//

import Foundation

enum FileManagerProviderError: Error {
    case badUrl,
         unableToDownloadData,
         unableToFindDocumentsDirectory,
         unableToWriteDataToFile
}
