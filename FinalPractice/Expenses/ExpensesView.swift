//
//  ExpensesView.swift
//  FinalPractice
//
//  Created by Владимир on 30.04.2023.
//

import UIKit
import CoreData
import SnapKit
var typeOfExpenses1 = [TypeOfExpenses]()
class ExpensesView: UIViewController  {
    
    //MARK: UI Elemnts
    
    private lazy var expensesLabel: UILabel = {
        let label = UILabel()
        label.text = "Расходы"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    private lazy var actionSheet: UIAlertController = {
        let actionSheet = UIAlertController(title: "\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        actionSheet.view.backgroundColor = .white
        actionSheet.view.addSubview(expensesTextField)
        actionSheet.view.addSubview(addExpensesButtonSheet)
        addConstrToSheet()
        return actionSheet
    }()
    private lazy var addExpensesButtonSheet: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.isEnabled = false
        button.layer.opacity = 0.5
        button.backgroundColor = .systemBlue
        button.setTitle("Добавить категорию расходов", for: .normal)
        button.addTarget(self, action: #selector(onButton), for: .touchUpInside)
        return button
    }()
    private lazy var expensesTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Наименование"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(didEdited), for: .editingChanged)
        return textField
    }()
    private lazy var addTypeOfExpenses: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить категорию расходов", for: .normal)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(addExpens), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        return button
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ExpensesCell.self, forCellReuseIdentifier: "ExpensesCell")
        return tableView
    }()
    
    //MARK: Lify cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeOfExpenses1 = DataManagerRelations.shared.typeOfExpenses()
        view.backgroundColor = .white
        setViews()
        setConstr()
        tableView.dataSource = self
        tableView.delegate = self
    }
    private func setViews() {
        view.addSubview(expensesLabel)
        view.addSubview(tableView)
        view.addSubview(addTypeOfExpenses)
    }
    private func setConstr() {
        expensesLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
        }
        addTypeOfExpenses.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(tableView.snp.bottom).offset(43)
            make.bottom.equalToSuperview().offset(-120)
        }
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.bottom.equalToSuperview().offset(-228)
        }
    }
    private func addConstrToSheet() {
        expensesTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(20)
        }
        addExpensesButtonSheet.snp.makeConstraints { make in
            make.top.equalTo(expensesTextField.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-28)
        }
    }
    @objc func onButton() {
        let typeOf = DataManagerRelations.shared.typeOfExpense(name: expensesTextField.text ?? "")
        typeOfExpenses1.append(typeOf)
        DataManagerRelations.shared.save()
        tableView.reloadData()
        actionSheet.dismiss(animated: true)
        addExpensesButtonSheet.isEnabled = false
        addExpensesButtonSheet.layer.opacity = 0.5
        expensesTextField.text = nil
    }
    @objc func didEdited() {
        if let isEmpty = expensesTextField.text?.isEmpty {
            if isEmpty {
                addExpensesButtonSheet.layer.opacity = 0.5
                addExpensesButtonSheet.isEnabled = false
            } else {
                addExpensesButtonSheet.layer.opacity = 1
                addExpensesButtonSheet.isEnabled = true
            }
        }
    }
    @objc func addExpens() {
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    
}
extension ExpensesView: NSFetchedResultsControllerDelegate {
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
