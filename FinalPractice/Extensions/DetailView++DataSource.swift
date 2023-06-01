//
//  IncomeView+TableViewDataSource.swift
//  FinalPractice
//
//  Created by Владимир on 01.05.2023.
//

import Foundation
import UIKit
import CoreData

extension DetailView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses1.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expense = expenses1[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetatilCell", for: indexPath) as? DetatilCell
        
        cell?.purposeLabel.text = expense.name
        cell?.expensesLabel.text = "\(expense.value)"
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ru_RU")
        dateFormater.dateStyle = .short
        let date = dateFormater.string(from: expense.date ?? Date())
        cell?.dateLabel.text = date
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()
        label.text = "Сколько"
        label2.text = "Когда"
        label3.text = "На что"
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemGray5
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(label2)
        stackView.addArrangedSubview(label3)
        return stackView
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if editingStyle == .delete {
                let object = expenses1[indexPath.row]
                
                
                
                DataManagerRelations.shared.persistentContainer.viewContext.delete(object)
                expenses1.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                try? DataManagerRelations.shared.persistentContainer.viewContext.save()
                
            }
        }
        
        
    }
}
