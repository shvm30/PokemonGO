//
//  TittleCell.swift
//  FinalPractice
//
//  Created by Владимир on 30.04.2023.
//

import UIKit
import SnapKit

class DetatilCell: UITableViewCell {
    
    //MARK: UI Elemnts
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center

        return label
    }()
    lazy var expensesLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left

        return label
    }()
    lazy var purposeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .right
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
        contentView.addSubview(dateLabel)
        contentView.addSubview(purposeLabel)
        
    }
    private func setConstr() {
        expensesLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalTo(dateLabel).offset(-13)
            make.centerY.equalToSuperview()
        }
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        purposeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(dateLabel.snp.trailing).offset(45)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
}
