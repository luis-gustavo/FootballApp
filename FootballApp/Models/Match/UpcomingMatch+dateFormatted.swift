//
//  PreviousMatch+dateFormatted.swift
//  FootballApp
//
//  Created by Luis Gustavo on 22/03/23.
//

import Foundation
import Models

extension UpcomingMatch {
    var dateFormatted: String? {
        StringToDateFormatter.dateTimeFormatted(from: date)
    }
}
