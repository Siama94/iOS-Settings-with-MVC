//
//  ItemsSettings.swift
//  iOS-Settings with MVC
//
//  Created by Анастасия on 19.08.2021.
//

import Foundation

import UIKit

enum CellType {
    case standard
    case label
    case switchCell
}

struct ItemsSettings {
    let type: CellType
    let title: String
    var icon: UIImage?
    let iconBackgroundColor: UIColor
    var label: String?
    var isOn: Bool!
}
