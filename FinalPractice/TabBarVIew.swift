//
//  ViewController.swift
//  FinalPractice
//
//  Created by Владимир on 30.04.2023.
//

import UIKit

class ViewController: UITabBarController {
    
    private var incomesView = IncomeView()
    private var expensesView = UINavigationController(rootViewController: ExpensesView()) 
    private var graphView = GraphViewViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        incomesView.title = "Доходы"
        graphView.title = "График"
        expensesView.title = "Расходы"
        self.setViewControllers([incomesView, graphView, expensesView], animated: false)

    }
    
    
}

