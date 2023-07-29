//
//  GithubUserCellTableViewCell.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 21.07.23.
//

import UIKit

class GithubUserCellTableViewCell: UITableViewCell {

    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        return stack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        logoImageView.layer.cornerRadius = logoImageView.frame.width / 2
    }
    
    private func setup() {
        addViews()
        addConstraints()
    }
    
    private func addViews(){
        contentView.addSubview(stack)
        stack.addArrangedSubview(logoImageView)
        stack.addArrangedSubview(titleLabel)
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            logoImageView.heightAnchor.constraint(equalToConstant: 72),
            logoImageView.widthAnchor.constraint(equalToConstant: 72),
        ])
    }

}



extension GithubUserCellTableViewCell: ConfigurableCell {
    
    func configure (with model: CellModel) {
        guard let model = model as? ViewModel else { return }
        logoImageView.image = model.avatar
        titleLabel.text = model.username
    }

}


extension GithubUserCellTableViewCell {
    
    struct ViewModel: CellModel {
        var cellIdentifier: String {
            return "GithubUserCellTableViewCell"
        }
        let avatar: UIImage?
        let username: String
    }
    
}
