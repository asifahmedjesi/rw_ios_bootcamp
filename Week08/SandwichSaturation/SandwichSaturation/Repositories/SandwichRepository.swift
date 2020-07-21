//
//  SandwichRepository.swift
//  SandwichSaturation
//
//  Created by Asif Ahmed Jesi on 20/7/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import Foundation
import CoreData

class SandwichRepository {
    private var context: NSManagedObjectContext
    private var sauceAmountRepository: SauceAmountRepository
    
    public init(context: NSManagedObjectContext, sauceAmountRepository: SauceAmountRepository) {
        self.context = context
        self.sauceAmountRepository = sauceAmountRepository
    }
    
    var count: Int {
        get {
            do {
                let request = SandwichModel.fetchRequest() as NSFetchRequest<SandwichModel>
                let results = try context.fetch(request)
                return results.count
            } catch let error {
                print(error)
            }
            return 0
        }
    }
    
    func populateSearchAndFilterRequest(query: String = "", sauceAmount: SauceAmount? = nil) -> NSFetchRequest<SandwichModel> {
        let request = SandwichModel.fetchRequest() as NSFetchRequest<SandwichModel>
        var predicates: [NSPredicate] = []
        
        if let sauce = sauceAmount {
            predicates.append(populatePredicate(for: sauce))
        }
        
        if !query.isEmpty {
            predicates.append(NSPredicate(format: "name BEGINSWITH[cd] %@", query))
        }
        
        switch predicates.count {
        case 1:
            request.predicate = predicates.first
        case 2:
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        default:
            print("No search and filtering available.")
        }
        
        let sort = NSSortDescriptor(key: #keyPath(SandwichModel.name), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        request.sortDescriptors = [sort]
        
        return request
    }
    
    func addSandwich(sandwich: SandwichData) {
        let entity = SandwichModel(entity: SandwichModel.entity(), insertInto: context)
        entity.imageName = sandwich.imageName
        entity.name = sandwich.name
        if let sauceAmount = sauceAmountRepository.getSauceAmountModel(by: sandwich.sauceAmount) {
            entity.sauceAmount = sauceAmount
        }
    }
    func addSandwiches(sandwiches: [SandwichData]) {
        for sandwich in sandwiches {
            addSandwich(sandwich: sandwich)
        }
    }
    
    private func populatePredicate(for sauceAmount: SauceAmount) -> NSPredicate {
        switch sauceAmount {
            case .any:
                let nonePredicate = NSPredicate(format: "sauceAmount.sauceAmountString == %@", SauceAmount.none.rawValue)
                let tooMuchPredicate = NSPredicate(format: "sauceAmount.sauceAmountString == %@", SauceAmount.tooMuch.rawValue)
                return NSCompoundPredicate(orPredicateWithSubpredicates: [nonePredicate, tooMuchPredicate])
            case .none:
                return NSPredicate(format: "sauceAmount.sauceAmountString == %@", SauceAmount.none.rawValue)
            case .tooMuch:
                return NSPredicate(format: "sauceAmount.sauceAmountString == %@", SauceAmount.tooMuch.rawValue)
        }
    }
}
