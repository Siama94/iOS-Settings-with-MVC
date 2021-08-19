//
//  SettingsLabelTableViewCell.swift
//  iOS-Settings with MVC
//
//  Created by Анастасия on 19.08.2021.
//

import UIKit

class SettingsLabelTableViewCell: UITableViewCell {

    static let identifier = "SettingsLabelTableViewCell"

    // MARK: - Configuration

    func configureCell(with model: Settings) {
        labelTitle.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColor
        labelDescription.text = model.title
    }

    // MARK: - Views

    public lazy var iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true

        return view
    }()

    public lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    public lazy var labelTitle: UILabel = {
        let label = UILabel()

        return label
    }()

    public lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray

        return label
    }()

    // MARK: - Initial

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        contentView.addSubview(labelTitle)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(labelDescription)

    }

    private func setupLayout() {

        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            labelTitle.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            labelTitle.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 8),
            labelTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            iconContainer.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            iconContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            iconContainer.widthAnchor.constraint(equalToConstant: 32),
            iconContainer.heightAnchor.constraint(equalToConstant: 32),

            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: iconContainer.leadingAnchor, constant: 3),
            iconImageView.widthAnchor.constraint(equalToConstant: 26),
            iconImageView.heightAnchor.constraint(equalToConstant: 26),

            labelDescription.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            labelDescription.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
    }
}
