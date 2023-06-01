//
//  TittleCell.swift
//  FinalPractice
//
//  Created by Владимир on 30.04.2023.
//

import UIKit
import SnapKit

class IncomesCell: UITableViewCell {
    
    //MARK: UI Elemnts
    
    lazy var incomeLabel: UILabel = {
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
        contentView.addSubview(incomeLabel)
    }
    private func setConstr() {
        incomeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
}
