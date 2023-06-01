//
//  TittleCell.swift
//  FinalPractice
//
//  Created by Владимир on 30.04.2023.
//

import UIKit
import SnapKit

class ExpensesCell: UITableViewCell {
    
    //MARK: UI Elemnts
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .systemBlue
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.frame.size.height = 20
        imageView.frame.size.width = 20
        return imageView
    }()
    lazy var expensesLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    //MARK: Init
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setElements()
        setConstr()
    }
    //MARK: Private Funcs
    private func setElements() {
        contentView.addSubview(expensesLabel)
        contentView.addSubview(image)
    }
    private func setConstr() {
        expensesLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-55)
            make.centerY.equalToSuperview()
        }
        image.snp.makeConstraints { make in
            make.leading.equalTo(expensesLabel.snp.trailing).offset(22)
            make.trailing.equalToSuperview().offset(-21)
            make.centerY.equalToSuperview()
            
        }
    }
}
