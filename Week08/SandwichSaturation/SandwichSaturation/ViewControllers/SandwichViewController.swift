//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

protocol SandwichDataSource {
    func saveSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController, SandwichDataSource {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var fetchedRC: NSFetchedResultsController<SandwichModel>!
    
    let searchController = UISearchController(searchResultsController: nil)
    var sandwiches = [SandwichData]()
    var filteredSandwiches = [SandwichData]()
    let defaults = UserDefaults.standard
    let selectedScopeKey = "SELECTED_SCOPE_KEY"
    var queryText: String = ""
    
    var selectedScopeIndex: Int {
        get {
            return defaults.integer(forKey: selectedScopeKey)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadSauceAmounts()
        loadSandwiches()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        // Setup Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Filter Sandwiches"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
        searchController.searchBar.delegate = self
        
        //let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(gestureRecognizer:)))
        //tableView.addGestureRecognizer(longPress)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchController.searchBar.selectedScopeButtonIndex = selectedScopeIndex
        showEditButton()
    }
    
    func loadSauceAmounts() {
        do {
            let request = SauceAmountModel.fetchRequest() as NSFetchRequest<SauceAmountModel>
            let results = try context.fetch(request)
            
            if results.count == 0 {
                for sauceAmount in SauceAmount.allCases {
                    if sauceAmount == .any { continue }
                    addSauceAmount(sauceAmount)
                }
                appDelegate.saveContext()
            }
        }
        catch let error {
            print(error)
        }
    }
    func loadSandwiches() {
        guard let sandwichesJSONURL = Bundle.main.url(forResource: "sandwiches", withExtension: "json")
            else { return }

        let decoder = JSONDecoder()

        do {
            let request = SandwichModel.fetchRequest() as NSFetchRequest<SandwichModel>
            let results = try context.fetch(request)
            
            if results.count == 0 {
                let sandwichesData = try Data(contentsOf: sandwichesJSONURL)
                sandwiches = try decoder.decode([SandwichData].self, from: sandwichesData)
                for sandwich in sandwiches {
                    addSandwich(sandwich)
                }
                appDelegate.saveContext()
            }
            
            switch selectedScopeIndex {
            case 1:
                let sauceAmount = SauceAmount(rawValue: SauceAmount.none.rawValue)
                refresh(query: "", sauceAmount: sauceAmount)
            case 2:
                let sauceAmount = SauceAmount(rawValue: SauceAmount.tooMuch.rawValue)
                refresh(query: "", sauceAmount: sauceAmount)
            default:
                refresh()
            }
            
        } catch let error {
            print(error)
        }
        
    }
    
    private func getPredicate(for sauceAmount: SauceAmount) -> NSPredicate {
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
    
    private func refresh(query: String = "", sauceAmount: SauceAmount? = nil) {
        let request = SandwichModel.fetchRequest() as NSFetchRequest<SandwichModel>
        var predicates: [NSPredicate] = []
        
        if let sauce = sauceAmount {
            predicates.append(getPredicate(for: sauce))
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
        do {
            fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedRC.delegate = self
            try fetchedRC.performFetch()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
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
    func addSauceAmount(_ sauceAmount: SauceAmount) {
        let entity = SauceAmountModel(entity: SauceAmountModel.entity(), insertInto: context)
        entity.sauceAmountString = sauceAmount.rawValue
    }
    func addSandwich(_ sandwich: SandwichData) {
        let entity = SandwichModel(entity: SandwichModel.entity(), insertInto: context)
        entity.imageName = sandwich.imageName
        entity.name = sandwich.name
        if let sauceAmount = getSauceAmountModel(by: sandwich.sauceAmount) {
            entity.sauceAmount = sauceAmount
        }
    }
    
    func saveSandwich(_ sandwich: SandwichData) {
        addSandwich(sandwich)
        appDelegate.saveContext()
        let sauceAmount = SauceAmount(rawValue: searchController.searchBar.scopeButtonTitles![selectedScopeIndex])
        refresh(query: queryText, sauceAmount: sauceAmount)
    }
    @IBAction func handleLongPress(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state != .ended {
            return
        }
        let point = gestureRecognizer.location(in: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) { // collectionView.indexPathForItem(at: point) {
            let pet = fetchedRC.object(at: indexPath)
            context.delete(pet)
            appDelegate.saveContext()
            let sauceAmount = SauceAmount(rawValue: searchController.searchBar.scopeButtonTitles![selectedScopeIndex])
            refresh(query: queryText, sauceAmount: sauceAmount)
        }
    }
    
    @objc
    func presentAddView(_ sender: Any) {
        performSegue(withIdentifier: "AddSandwichSegue", sender: self)
    }
    
    private func showEditButton() {
        guard let objs = fetchedRC.fetchedObjects else {
            return
        }
        if objs.count > 0 {
            navigationItem.leftBarButtonItem = editButtonItem
        }
    }
    
    // MARK: - Search Controller
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    func filterContentForSearchText(_ searchText: String, sauceAmount: SauceAmount? = nil) {
        refresh(query: searchText, sauceAmount: sauceAmount)
        tableView.reloadData()
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedRC.fetchedObjects?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
            else { return UITableViewCell() }
        
        let sandwich = fetchedRC.object(at: indexPath)
        
        cell.thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName)
        cell.nameLabel.text = sandwich.name
        cell.sauceLabel.text = sandwich.sauceAmount.sauceAmount.rawValue
        
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entity = fetchedRC.object(at: indexPath)
            context.delete(entity)
            appDelegate.saveContext()
            let sauceAmount = SauceAmount(rawValue: searchController.searchBar.scopeButtonTitles![selectedScopeIndex])
            refresh(query: queryText, sauceAmount: sauceAmount)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension SandwichViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        let index = indexPath ?? (newIndexPath ?? nil)
        guard let rowIndex = index else {
            return
        }
        
        if type == .insert {
            tableView.insertRows(at: [rowIndex], with: .automatic)
        }
        
        /*
        switch type {
        case .insert:
            tableView.insertRows(at: [rowIndex], with: .automatic) // .insertItems(at: [cellIndex])
        //case .delete:
        //    tableView.deleteRows(at: [rowIndex], with: .automatic) // .deleteItems(at: [cellIndex])
        default:
            break
        }
        */
        
    }
    
}

// MARK: - UISearchResultsUpdating
extension SandwichViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let sauceAmount = SauceAmount(rawValue:searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
        queryText = searchBar.text!
        filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
    }
}

// MARK: - UISearchBarDelegate
extension SandwichViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        defaults.set(selectedScope, forKey: selectedScopeKey)
        let sauceAmount = SauceAmount(rawValue: searchBar.scopeButtonTitles![selectedScope])
        filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
    }
}

