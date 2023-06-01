//
//  GraphViewViewController.swift
//  FinalPractice
//
//  Created by Владимир on 23.05.2023.
//


import UIKit
import SwiftUI
class GraphViewViewController: UIViewController {
    private lazy var weekButton: UIButton = {
        let button = UIButton()
        button.setTitle("Неделя", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(weekButtonPressed), for: .touchUpInside)
        return button
    }()
    private lazy var monthButton: UIButton = {
        let button = UIButton()
        button.setTitle("Месяц", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(monthButtonPressed), for: .touchUpInside)
        return button
    }()
    private lazy var quarterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Квартал", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(quarterButtonPressed), for: .touchUpInside)
        return button
    }()
    private lazy var allTimeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Все", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(allTimeButtonPressed), for: .touchUpInside)
        return button
    }()
    override func viewWillAppear(_ animated: Bool) {
        view.subviews.forEach { $0.removeFromSuperview()}
        setViews()
        setConstr()
        listOfIncomes = DataManagerRelations.shared.incomesForGraphs()
        list = DataManagerRelations.shared.expensesForGraph()
        setGraph()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        listOfIncomes = DataManagerRelations.shared.incomesForGraphs()
        list = DataManagerRelations.shared.expensesForGraph()
        setViews()
        setConstr()
        setGraph()
    }
    private func setViews() {
        view.addSubview(weekButton)
        view.addSubview(monthButton)
        view.addSubview(quarterButton)
        view.addSubview(allTimeButton)
    }
    private func setGraph() {
        let controller = UIHostingController(rootView: ChartViewIE())
        guard let graphView = controller.view else { return }
        view.addSubview(graphView)
        graphView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset (15)
            make.top.equalToSuperview().offset(267)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-250)
            
        }
    }
    @objc private func weekButtonPressed() {
        view.subviews.forEach { $0.removeFromSuperview()}
        setViews()
        setConstr()
        list = DataManagerRelations.shared.expensesForGraph().filter {
            $0.date! <= Date() && $0.date! >= Date() - TimeInterval(604800)
        }
        listOfIncomes = DataManagerRelations.shared.incomesForGraphs().filter {
            $0.date! <= Date() && $0.date! >= Date() - TimeInterval(604800)
        }
        setGraph()
        
        
    }
    @objc private func monthButtonPressed() {
        view.subviews.forEach { $0.removeFromSuperview()}
        setViews()
        setConstr()
        list = DataManagerRelations.shared.expensesForGraph().filter {
            $0.date! <= Date() && $0.date! >= Date() - TimeInterval(2592000)
        }
        listOfIncomes = DataManagerRelations.shared.incomesForGraphs().filter {
            $0.date! <= Date() && $0.date! >= Date() - TimeInterval(2592000)
        }
        setGraph()
    }
    @objc private func quarterButtonPressed() {
        view.subviews.forEach { $0.removeFromSuperview()}
        setViews()
        setConstr()
        list = DataManagerRelations.shared.expensesForGraph().filter {
            $0.date! <= Date() && $0.date! >= Date() - TimeInterval(7776000)
        }
        listOfIncomes = DataManagerRelations.shared.incomesForGraphs().filter {
            $0.date! <= Date() && $0.date! >= Date() - TimeInterval(7776000)
        }
        setGraph()
    }
    @objc private func allTimeButtonPressed() {
        view.subviews.forEach { $0.removeFromSuperview()}
        setViews()
        setConstr()
        listOfIncomes = DataManagerRelations.shared.incomesForGraphs()
        list = DataManagerRelations.shared.expensesForGraph()
        setGraph()
    }
 
    private func setConstr() {
        weekButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.top.equalToSuperview().offset(156)
        }
        monthButton.snp.makeConstraints { make in
            make.leading.equalTo(weekButton.snp.trailing).offset(23)
            make.top.equalToSuperview().offset(156)
        }
        quarterButton.snp.makeConstraints { make in
            make.leading.equalTo(monthButton.snp.trailing).offset(25)
            make.top.equalToSuperview().offset(156)
        }
        allTimeButton.snp.makeConstraints { make in
            make.leading.equalTo(quarterButton.snp.trailing).offset(27)
            make.top.equalToSuperview().offset(156)
            
        
        }
    }
}


