//
//  SettingsView.swift
//  iOS-Settings with MVC
//
//  Created by Анастасия on 19.08.2021.
//

import UIKit

final class SettingsView: UIView {

    // MARK: - Configuration

    func configureView(with models: [String : [ItemsSettings]]) {
        self.models = models
    }

    // MARK: - Private properties

    private var models = SettingsModel().configureCell

    // MARK: - Views

    private lazy var tableView: UITableView = {

        let table = UITableView(frame: .zero, style: .grouped)

        table.register(SettingsStandardViewCell.self, forCellReuseIdentifier: SettingsStandardViewCell.identifier)
        table.register(SettingsLabelTableViewCell.self, forCellReuseIdentifier: SettingsLabelTableViewCell.identifier)
        table.register(SettingsSwitchTableViewCell.self, forCellReuseIdentifier: SettingsSwitchTableViewCell.identifier)

        table.delegate = self
        table.dataSource = self

        return table

    }()

    // MARK: - Initial

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Settings

    private func setupHierarchy() {
        addSubview(tableView)
    }

    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension SettingsView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        models.keys.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models["Section\(section)"]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = models["Section\(indexPath.section)"]?[indexPath.row] else {
            return UITableViewCell()
        }

            switch data.type {
            case .standard:
                return setupStandardCell(for: indexPath, with: data)
            case .switchCell:
                return setupSwitchCell(for: indexPath, with: data)
            case .label:
                return setupLabelCell(for: indexPath, with: data)
            }
        }

        private func setupStandardCell(for indexPath: IndexPath, with data: ItemsSettings) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsStandardViewCell.identifier, for: indexPath) as? SettingsStandardViewCell else { return UITableViewCell() }
            cell.labelTitle.text = data.title
            cell.iconImageView.image = data.icon
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.iconContainer.backgroundColor = data.iconBackgroundColor

            return cell
        }

        private func setupLabelCell(for indexPath: IndexPath, with data: ItemsSettings) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsLabelTableViewCell.identifier, for: indexPath) as? SettingsLabelTableViewCell else { return UITableViewCell() }
            cell.labelTitle.text = data.title
            cell.iconImageView.image = data.icon
            cell.labelDescription.text = data.label
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.iconContainer.backgroundColor = data.iconBackgroundColor

            return cell
        }

        private func setupSwitchCell(for indexPath: IndexPath, with data: ItemsSettings) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsSwitchTableViewCell.identifier, for: indexPath) as? SettingsSwitchTableViewCell else { return UITableViewCell() }
            cell.labelTitle.text = data.title
            cell.iconImageView.image = data.icon
            cell.switchItem.isOn = data.isOn!
            cell.iconContainer.backgroundColor = data.iconBackgroundColor

            return cell
        }
}

// MARK: - UITableViewDelegate

extension SettingsView:  UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = models["Section\(indexPath.section)"]?[indexPath.row]{
            print("Нажата ячейка \(data.title)")
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
