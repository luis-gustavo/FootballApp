//
//  TestingRootViewController.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import UIKit

final class TestingRootViewController: UIViewController {

    override func loadView() {
        let label = UILabel()
        label.text = "Running Unit Tests..."
        label.textAlignment = .center
        label.textColor = .white

        view = label
    }
}
