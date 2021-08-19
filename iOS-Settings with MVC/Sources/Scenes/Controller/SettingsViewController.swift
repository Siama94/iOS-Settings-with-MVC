//
//  ViewController.swift
//  iOS-Settings with MVC
//
//  Created by Анастасия on 19.08.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    var model: SettingsModel?

    private var onboardingView: SettingsView? {
        guard isViewLoaded else { return nil }
        return view as? SettingsView
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view = SettingsView()
        model = SettingsModel()

        navigationItem.title = "Настройки"

        configureView()
    }
}

// MARK: - Configurations

private extension SettingsViewController {
    func configureView() {
        guard let models = model?.configureCell else { return }
        onboardingView?.configureView(with: models)
    }
}
