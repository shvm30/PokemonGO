//
//  Expenses+CoreDataProperties.swift
//  FinalPractice
//
//  Created by Владимир on 26.05.2023.
//
//

import Foundation
import CoreData


extension Expenses {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expenses> {
        return NSFetchRequest<Expenses>(entityName: "Expenses")
    }

    @NSManaged public var name: String?
    @NSManaged public var value: Int64
    @NSManaged public var date: Date?
    @NSManaged public var typeOfExpenses: TypeOfExpenses?

}

extension Expenses : Identifiable {

}
