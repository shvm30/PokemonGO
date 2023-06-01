
import CoreData
import Foundation

class DataManagerRelations {
    static let shared = DataManagerRelations()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func typeOfExpense(name: String) -> TypeOfExpenses {
        let typeOfExpenses = TypeOfExpenses(context: persistentContainer.viewContext)
        typeOfExpenses.name = name
        try? typeOfExpenses.managedObjectContext?.save()
        return typeOfExpenses
    }
    func income(value: Int64, date: Date) -> Incomes {
        let income = Incomes(context: persistentContainer.viewContext)
        income.value = value
        income.date = date
        try? income.managedObjectContext?.save()
        return income
    }
    func incomes() -> [Incomes] {
        let request: NSFetchRequest<Incomes> = Incomes.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        var fetchedExpeneses: [Incomes] = []
        do {
            fetchedExpeneses = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print(error)
        }
        return fetchedExpeneses
    }
    func expens(name: String, date: Date, value: Int64, typeOfExpenses: TypeOfExpenses) -> Expenses {
        let expenses = Expenses(context: persistentContainer.viewContext)
        expenses.name = name
        expenses.date = date
        expenses.value = value
        typeOfExpenses.addToExpenses(expenses)
        try? expenses.managedObjectContext?.save()
        
        return expenses
    }
    func typeOfExpenses() -> [TypeOfExpenses] {
        let request: NSFetchRequest<TypeOfExpenses> = TypeOfExpenses.fetchRequest()
        var fetchedExpenses: [TypeOfExpenses] = []
        do {
            fetchedExpenses = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print(error)
        }
        return fetchedExpenses
    }
    func deleteExpenses(typeOfExpenses: TypeOfExpenses) {
        let request: NSFetchRequest<Expenses> = Expenses.fetchRequest()
        request.predicate = NSPredicate(format: "typeOfExpenses = %@", typeOfExpenses)
        do {
            let objects = try? persistentContainer.viewContext.fetch(request)
            objects?.forEach({ expenses in
                persistentContainer.viewContext.delete(expenses)
            })
            try? persistentContainer.viewContext.save()
        }
    }
    func expenses(typeOfExpenses: TypeOfExpenses) -> [Expenses] {
        let request: NSFetchRequest<Expenses> = Expenses.fetchRequest()
        request.predicate = NSPredicate(format: "typeOfExpenses = %@", typeOfExpenses)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        var fetchedExpeneses: [Expenses] = []
        do {
            fetchedExpeneses = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print(error)
        }
        return fetchedExpeneses
    }
    func expensesForGraph() -> [Expenses] {
        let request: NSFetchRequest<Expenses> = Expenses.fetchRequest()
        var fetchedExpeneses: [Expenses] = []
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        do {
            fetchedExpeneses = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print(error)
        }
        return fetchedExpeneses
       
    }
    func incomesForGraphs() -> [Incomes] {
        let request: NSFetchRequest<Incomes> = Incomes.fetchRequest()
        var fetchedIncomes: [Incomes] = []
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        do {
            fetchedIncomes = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print(error)
        }
        return fetchedIncomes
    }
}
