//
//  ViewController.swift
//  FinalPractice
//
//  Created by Владимир on 30.04.2023.
//

import UIKit
import SnapKit
import CoreData
class IncomeView: UIViewController {
    lazy var balanceArray: [Incomes] = [] {
        didSet{
            print(balanceArray)
            var balance = 0
            balanceArray.forEach { incomes in
                balance += Int(incomes.value)
            }
            self.balance = balance
        }
    }
    var balance: Int = 0
    
    var cuurentIncome: [Incomes] = []
    
    //MARK: UI Elements
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    private lazy var incomeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Cумма"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(didEdited), for: .editingChanged)
        textField.keyboardType = .numberPad
        return textField
    }()
    private lazy var actionSheet: UIAlertController = {
        let actionSheet = UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        actionSheet.view.backgroundColor = .white
        actionSheet.view.addSubview(incomeTextField)
        actionSheet.view.addSubview(addIncomeButtonSheet)
        actionSheet.view.addSubview(datePicker)
        addConstrToSheet()
        
        return actionSheet
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Доходы"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    private lazy var balanceLAbel: UILabel = {
        let label = UILabel()
        label.text = "Текущий баланс"
        label.numberOfLines = 2
        return label
    }()
    lazy var curentBalance: UILabel = {
        let label = UILabel()
        label.text = "Ваш баланс \(balance) р."
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var addIncomeButtonSheet: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.isEnabled = false
        button.layer.opacity = 0.5
        button.backgroundColor = .systemBlue
        button.setTitle("Добавить доход", for: .normal)
        button.addTarget(self, action: #selector(onButton), for: .touchUpInside)
        return button
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IncomesCell.self, forCellReuseIdentifier: "IncomesCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        return tableView
    }()
    private lazy var addIncomeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить доход", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(addIncome), for: .touchUpInside)
        return button
    }()
    @objc func addIncome() {
        present(actionSheet, animated: true, completion: nil)
    }
    @objc func onButton() {
        guard let value = Int64(incomeTextField.text ?? "") else { return }
        let income = DataManagerRelations.shared.income(value: value, date: datePicker.date)
        balanceArray.append(income)
        listOfIncomes.append(income)
        cuurentIncome.append(income)
        curentBalance.text = "Ваш баланс \(balance) р."
        tableView.reloadData()
        actionSheet.dismiss(animated: true)
        addIncomeButtonSheet.isEnabled = false
        addIncomeButtonSheet.layer.opacity = 0.5
        incomeTextField.text = nil
    }
    @objc func didEdited() {
        if let isEmpty = incomeTextField.text?.isEmpty {
            if isEmpty {
                addIncomeButtonSheet.layer.opacity = 0.5
                addIncomeButtonSheet.isEnabled = false
            } else {
                addIncomeButtonSheet.layer.opacity = 1
                addIncomeButtonSheet.isEnabled = true
            }
        }
    }
    //MARK: Life Cycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
//        list = DataManagerRelations.shared.expensesForGraph()
//        list.forEach { expenses in
//            DataManagerRelations.shared.persistentContainer.viewContext.delete(expenses)
//            try? DataManagerRelations.shared.persistentContainer.viewContext.save()
//        }
        cuurentIncome = DataManagerRelations.shared.incomes()
        
        balanceArray = cuurentIncome
        view.backgroundColor = .white
        addViews()
        addConstr()
    }
    
    //MARK: Private Funcs
    
    private func addViews() {
        view.addSubview(tableView)
        view.addSubview(addIncomeButton)
        view.addSubview(titleLabel)
        view.addSubview(curentBalance)
        view.addSubview(balanceLAbel)
        
    }
    private func addConstr() {
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.bottom.equalToSuperview().offset(-228)
        }
        addIncomeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(tableView.snp.bottom).offset(43)
            make.bottom.equalToSuperview().offset(-120)
        }
        balanceLAbel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-55)
            make.top.equalToSuperview().inset(83)
        }
        curentBalance.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(250)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().inset(83)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
    }
    private func addConstrToSheet() {
        incomeTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(20)
        }
        addIncomeButtonSheet.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-28)
        }
        datePicker.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(incomeTextField.snp.bottom).offset(15)

        }
    }
}

