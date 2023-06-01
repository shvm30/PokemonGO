//
//  DetatilView.swift
//  FinalPractice
//
//  Created by Владимир on 16.05.2023.
//

import UIKit
import Foundation
import SnapKit
import CoreData

class DetailView: UIViewController {
    var expenses1 = [Expenses]()
    var typeOf: TypeOfExpenses?
    private lazy var addExpensesButtonSheet: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.isEnabled = false
        button.layer.opacity = 0.5
        button.backgroundColor = .systemBlue
        button.setTitle("Добавить расход", for: .normal)
        button.addTarget(self, action: #selector(onButton), for: .touchUpInside)
        return button
    }()
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    private lazy var actionSheet: UIAlertController = {
        let actionSheet = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        actionSheet.view.backgroundColor = .white
        actionSheet.view.addSubview(sumTextField)
        actionSheet.view.addSubview(nameTextField)
        actionSheet.view.addSubview(datePicker)
        actionSheet.view.addSubview(addExpensesButtonSheet)
        addConstrToSheet()
        return actionSheet
    }()
    private lazy var sumTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Сумма"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(sumDidEdited), for: .editingChanged)
        return textField
    }()
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Наименование"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(nameDidEdited), for: .editingChanged)
        return textField
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Когда"
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .gray
        label.text = "Сколько"
        return label
    }()
    private lazy var purposeLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .systemGray
        label.text = "На что"
        return label
    }()
    private lazy var graphViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("График платежей", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(showGraph), for: .touchUpInside)
        button.layer.cornerRadius = 25
        return button
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DetatilCell.self, forCellReuseIdentifier: "DetatilCell")
        tableView.dataSource = self
        return tableView
    }()
    private lazy var addExpensesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(addExpens), for: .touchUpInside)
        button.layer.cornerRadius = 25
        return button
    }()
    private lazy var addExpensLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавить расход"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let typeOf = typeOf {
            expenses1 = DataManagerRelations.shared.expenses(typeOfExpenses: typeOf)
        }
        tableView.reloadData()
        view.backgroundColor = .white
        addElements()
        setConstraints()
        tableView.delegate = self
    }
    private func addElements() {
        view.addSubview(graphViewButton)
        view.addSubview(tableView)
        view.addSubview(addExpensesButton)
        view.addSubview(addExpensLabel)
    }
    private func setConstraints() {
        graphViewButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(120)
            make.bottom.equalToSuperview().offset(-675)
        }
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(graphViewButton.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-180)
        }
        addExpensesButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(170)
            make.trailing.equalToSuperview().offset(-170)
            make.top.equalToSuperview().offset(690)
            make.bottom.equalToSuperview().offset(-110)
        }
        addExpensLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(addExpensesButton.snp.bottom).offset(10)
        }
    }
    private func addConstrToSheet() {
        nameTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(15)
        }
        sumTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(nameTextField.snp.bottom).offset(15)
        }
        datePicker.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(sumTextField.snp.bottom).offset(15)
        }
        addExpensesButtonSheet.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(datePicker.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    @objc func onButton() {
        guard let sum = sumTextField.text else { return }
        let expenses = DataManagerRelations.shared.expens(name: nameTextField.text ?? "", date: datePicker.date, value: Int64(sum) ?? 0, typeOfExpenses: typeOf!)
        expenses1.append(expenses)
        tableView.reloadData()
        actionSheet.dismiss(animated: true)
        addExpensesButtonSheet.isEnabled = false
        addExpensesButtonSheet.layer.opacity = 0.5
        nameTextField.text = nil
        sumTextField.text = nil
    }
    @objc func addExpens() {
        present(actionSheet, animated: true, completion: nil)
        
    }
    @objc func showGraph() {
        let vc = ExpGraphView()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func sumDidEdited() {
        if let isEmpty = sumTextField.text?.isEmpty {
            if isEmpty {
                addExpensesButtonSheet.layer.opacity = 0.5
                addExpensesButtonSheet.isEnabled = false
            } else {
                addExpensesButtonSheet.layer.opacity = 1
                addExpensesButtonSheet.isEnabled = true
            }
        }
    }
    @objc func nameDidEdited() {
        
    }
}
extension DetailView: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                tableView.moveRow(at: indexPath, to: newIndexPath)
            }
        default:
            tableView.reloadData()
        }
    }
}
