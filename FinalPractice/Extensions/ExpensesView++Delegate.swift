//
//  ExpensesView++Delegate.swift
//  FinalPractice
//
//  Created by Владимир on 15.05.2023.
//

import Foundation
import UIKit

extension ExpensesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailView()
        vc.typeOf = typeOfExpenses1[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
