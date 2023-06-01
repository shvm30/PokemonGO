//
//  Incomes+CoreDataProperties.swift
//  FinalPractice
//
//  Created by Владимир on 26.05.2023.
//
//

import Foundation
import CoreData


extension Incomes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Incomes> {
        return NSFetchRequest<Incomes>(entityName: "Incomes")
    }

    @NSManaged public var value: Int64
    @NSManaged public var date: Date?

}

extension Incomes : Identifiable {

}
