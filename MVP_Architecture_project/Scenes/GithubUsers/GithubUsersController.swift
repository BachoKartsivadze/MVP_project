//
//  GithubUsersController.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 20.07.23.
//

import UIKit

class GithubUsersController: UIViewController {
    
    var presenter: GithubUsersPresenter!
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(TitleHeader.self, forHeaderFooterViewReuseIdentifier: "TitleHeader")
        view.register(GithubUserCellTableViewCell.self, forCellReuseIdentifier: "GithubUserCellTableViewCell")
        return view
    }()
    
    private init(with configurator: GithubUsersConfigurator) {
        super.init (nibName: nil, bundle: nil)
        configurator.configure(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: UIViewController Lifecycle
extension GithubUsersController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubViews()
        addConstraints()
        view.backgroundColor = .blue.withAlphaComponent(0.2)
        
    }
}

// MARK: setup
extension GithubUsersController {
    
    private func addSubViews() {
        view.addSubview(tableView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint (equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint (equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint (equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint (equalTo: view.bottomAnchor)
        ])
    }
}


extension GithubUsersController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.number0fRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = presenter.rowIdentifier(at: indexPath)
        let dequeued = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let cell = dequeued as! ConfigurableCell
        presenter.configure(row: cell, at: indexPath)
        return dequeued
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let identifier = presenter.headerIdentifier(of: section)
        let dequeued = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        let header = dequeued as! ConfigurableCell
        presenter.configure (header: header, in: section)
        return dequeued
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        var textForAction = "Favourite"
//        if indexPath.section == 0 {
//            textForAction = "Unfavourite"
//        }
//        let cell = tableView.cellForRow(at: indexPath) as! GithubUserCellTableViewCell
        
        
        let textForAction = presenter.textForAction(at: indexPath)
        let action = UIContextualAction(style: .normal, title: textForAction, handler: {[unowned self] _,_,_ in
            presenter.tapFavoriteUnfavorite(at: indexPath)
        })
        
        return UISwipeActionsConfiguration(actions: [action])
    }


}


extension GithubUsersController: GithubUsersView {
    func reloadList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}

// MARK: Static Initializer
extension GithubUsersController {
    static func instantiate() -> GithubUsersController {
        let configurator = GithubUsersConfiguratorImp1()
        let vc = GithubUsersController (with: configurator)
        return vc
    }
}

