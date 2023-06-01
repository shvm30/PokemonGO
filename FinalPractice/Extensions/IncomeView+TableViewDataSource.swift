//
//  IncomeView+TableViewDataSource.swift
//  FinalPractice
//
//  Created by Владимир on 01.05.2023.
//

import Foundation
import UIKit

extension IncomeView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cuurentIncome.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let typeOf = cuurentIncome[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "IncomesCell", for: indexPath) as? IncomesCell
        cell?.incomeLabel.text = "\(typeOf.value)"
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let income = DataManagerRelations.shared.incomes()
            DataManagerRelations.shared.persistentContainer.viewContext.delete(income[indexPath.row])
           try? DataManagerRelations.shared.persistentContainer.viewContext.save()
            cuurentIncome.remove(at: indexPath.row)
            balanceArray.remove(at: indexPath.row)
            var balance = 0
            balanceArray.forEach { incomes in
                balance += Int(incomes.value)
            }

            self.balance = balance
            curentBalance.text = "Ваш баланс \(balance) р."
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
