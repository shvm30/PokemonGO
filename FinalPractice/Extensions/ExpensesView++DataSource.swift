//
//  IncomeView+TableViewDataSource.swift
//  FinalPractice
//
//  Created by Владимир on 01.05.2023.
//

import Foundation
import UIKit

extension ExpensesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let sections = fetchedResultController.sections {
//            return sections[section].numberOfObjects
//        }
//        return 0
        typeOfExpenses1.count
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return fetchedResultController.sections?.count ?? 0
//
//
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let typeOf = typeOfExpenses1[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpensesCell", for: indexPath) as? ExpensesCell
        cell?.expensesLabel.text = typeOf.name
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let object = typeOfExpenses1[indexPath.row]
            DataManagerRelations.shared.deleteExpenses(typeOfExpenses: object)

            let expenses = DataManagerRelations.shared.expenses(typeOfExpenses: object)
            expenses.forEach { expense in
                DataManagerRelations.shared.persistentContainer.viewContext.delete(expense)
            }
            DataManagerRelations.shared.persistentContainer.viewContext.delete(object)
            typeOfExpenses1.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

           try? DataManagerRelations.shared.persistentContainer.viewContext.save()

        }
    }
}
