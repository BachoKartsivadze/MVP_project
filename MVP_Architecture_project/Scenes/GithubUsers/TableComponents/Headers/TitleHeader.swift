//
//  TitleHeader.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 20.07.23.
//

import UIKit

class TitleHeader: UITableViewHeaderFooterView {

    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .white
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        return stack
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addViews()
        addConstraints()
        contentView.backgroundColor = .systemBlue
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
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            logoImageView.heightAnchor.constraint(equalToConstant: 36),
            logoImageView.widthAnchor.constraint(equalToConstant:36),
        ])
    }
}


extension TitleHeader: ConfigurableCell {
    
    func configure (with model: CellModel) {
        guard let model = model as? ViewModel else { return }
        logoImageView.image = model.logo
        titleLabel.text = model.title
    }

}


extension TitleHeader {
    
    struct ViewModel: CellModel {
        var cellIdentifier: String {
            return "TitleHeader"
        }
        let logo: UIImage
        let title: String
    }
    
}
