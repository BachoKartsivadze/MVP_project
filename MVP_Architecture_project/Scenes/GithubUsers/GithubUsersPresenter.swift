//
//  GithubUsersPresenter.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 20.07.23.
//

import Foundation
import UIKit

protocol GithubUsersView: AnyObject {
    
}

protocol GithubUsersPresenter {
    func viewDidLoad()
    var numberOfSections: Int { get }
    func number0fRows (in section: Int) -> Int
    func headerIdentifier(of section: Int) -> String
    func rowIdentifier(at indexPath: IndexPath) -> String
    func configure (header: ConfigurableCell, in section: Int)
    func configure (row: ConfigurableCell, at indexPath: IndexPath)
}

class GithubUsersPresenterImp1: GithubUsersPresenter {
    
    private weak var view: GithubUsersView?
    private var router: GithubUsersRouter
    
    private var listDataSource: [SectionModel] = [
        SectionModel (
            headerModel: TitleHeader.ViewModel (
                logo: UIImage(named: "gitjub_logo4")!, title: "Favorites"
        ),
            cellModels: [
                GithubUserCellTableViewCell.ViewModel(avatar: UIImage(), username: "Jon Doe")
            ]
        ),
        
        SectionModel (
            headerModel: TitleHeader.ViewModel (
                logo: UIImage (named: "gitjub_logo4")!, title: "Users"
            ),
            cellModels: [
                GithubUserCellTableViewCell.ViewModel(avatar: UIImage(), username: "Jon Doe")
            ]
        )
    ]
    
    init(view: GithubUsersView, router: GithubUsersRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
    
    
}

extension GithubUsersPresenterImp1 {
    
    var numberOfSections: Int {
        return listDataSource.count
    }
    
    func number0fRows (in section: Int) -> Int {
        return listDataSource[section].cellModels.count
    }
    
    func headerIdentifier(of section: Int) -> String {
        return listDataSource [section].headerModel.cellIdentifier
    }
    
    func rowIdentifier(at indexPath: IndexPath) -> String {
        return listDataSource[indexPath.section].cellModels[indexPath.row].cellIdentifier
    }
    
    func configure (header: ConfigurableCell, in section: Int) {
        header.configure(with: listDataSource [section].headerModel)
    }
    
    func configure (row: ConfigurableCell, at indexPath: IndexPath) {
        row.configure(with: listDataSource[indexPath.section].cellModels[indexPath.row])
    }
    
}
