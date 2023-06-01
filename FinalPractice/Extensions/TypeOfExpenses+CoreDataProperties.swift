//
//  TypeOfExpenses+CoreDataProperties.swift
//  FinalPractice
//
//  Created by Владимир on 26.05.2023.
//
//

import Foundation
import CoreData


extension TypeOfExpenses {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TypeOfExpenses> {
        return NSFetchRequest<TypeOfExpenses>(entityName: "TypeOfExpenses")
    }

    @NSManaged public var name: String?
    @NSManaged public var expenses: NSSet?

}

// MARK: Generated accessors for expenses
extension TypeOfExpenses {

    @objc(addExpensesObject:)
    @NSManaged public func addToExpenses(_ value: Expenses)

    @objc(removeExpensesObject:)
    @NSManaged public func removeFromExpenses(_ value: Expenses)

    @objc(addExpenses:)
    @NSManaged public func addToExpenses(_ values: NSSet)

    @objc(removeExpenses:)
    @NSManaged public func removeFromExpenses(_ values: NSSet)

}

extension TypeOfExpenses : Identifiable {

}
