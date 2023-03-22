//
//  HighlightFooterViewModel.swift
//  FootballApp
//
//  Created by Luis Gustavo on 22/03/23.
//

import Combine
import Foundation

struct HighlightFooterViewModel {
    private(set) var tappedWatchHighlight = PassthroughSubject<Void, Never>()
}

// MARK: - Internal methods
extension HighlightFooterViewModel {
    func showHighlight() {
        tappedWatchHighlight.send()
    }
}
