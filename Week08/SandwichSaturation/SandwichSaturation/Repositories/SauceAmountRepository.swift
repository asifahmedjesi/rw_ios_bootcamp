//
//  SauceAmountRepository.swift
//  SandwichSaturation
//
//  Created by Asif Ahmed Jesi on 20/7/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import Foundation
import CoreData

class SauceAmountRepository {
    private var context: NSManagedObjectContext
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    var count: Int {
        get {
            do {
                let request = SauceAmountModel.fetchRequest() as NSFetchRequest<SauceAmountModel>
                let results = try context.fetch(request)
                return results.count
            } catch let error {
                print(error)
            }
            return 0
        }
    }
    
    func getSauceAmountModel(by sauceAmount: SauceAmount) -> SauceAmountModel? {
        do {
            let request = SauceAmountModel.fetchRequest() as NSFetchRequest<SauceAmountModel>
            request.predicate = NSPredicate(format: "sauceAmountString == %@", sauceAmount.rawValue)
            let results = try context.fetch(request)
            
            if let result = results.first {
                return result
            }
            else {
                return nil
            }
        }
        catch let error {
            print(error)
        }
        
        return nil
    }
    
    func addSauceAmount(amount: SauceAmount) {
        let entity = SauceAmountModel(entity: SauceAmountModel.entity(), insertInto: context)
        entity.sauceAmountString = amount.rawValue
    }
    func addSauceAmounts(amounts: [SauceAmount]) {
        for sauceAmount in amounts {
            if sauceAmount == .any { continue }
            addSauceAmount(amount: sauceAmount)
        }
    }
    
}
