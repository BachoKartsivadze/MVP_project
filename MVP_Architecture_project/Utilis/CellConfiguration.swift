//
//  CellConfiguration.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 18.07.23.
//

import Foundation

protocol CellModel {
    var cellIdentifier: String { get }
}

protocol ConfigurableCell {
    func configure(with model: CellModel)
}

struct SectionModel {
    let headerModel: CellModel
    let cellModels: [CellModel]
}
