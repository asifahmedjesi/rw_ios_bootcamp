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
    private var sandwichRepository: SandwichRepository!
    private var sauceAmountRepository: SauceAmountRepository!
    
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
        
        sauceAmountRepository = SauceAmountRepository(context: context)
        sandwichRepository = SandwichRepository(context: context, sauceAmountRepository: sauceAmountRepository)
        
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
        if sauceAmountRepository.count > 0 { return }
        sauceAmountRepository.addSauceAmounts(amounts: SauceAmount.allCases)
        appDelegate.saveContext()
    }
    func loadSandwiches() {
        guard let sandwichesJSONURL = Bundle.main.url(forResource: "sandwiches", withExtension: "json")
            else { return }

        let decoder = JSONDecoder()

        do {
            if sandwichRepository.count == 0 {
                let sandwichesData = try Data(contentsOf: sandwichesJSONURL)
                sandwiches = try decoder.decode([SandwichData].self, from: sandwichesData)
                sandwichRepository.addSandwiches(sandwiches: sandwiches)
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

    private func refresh(query: String = "", sauceAmount: SauceAmount? = nil) {
        let request = sandwichRepository.populateSearchAndFilterRequest(query: query, sauceAmount: sauceAmount)
        do {
            fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedRC.delegate = self
            try fetchedRC.performFetch()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func saveSandwich(_ sandwich: SandwichData) {
        sandwichRepository.addSandwich(sandwich: sandwich)
        appDelegate.saveContext()
        let sauceAmount = SauceAmount(rawValue: searchController.searchBar.scopeButtonTitles![selectedScopeIndex])
        refresh(query: queryText, sauceAmount: sauceAmount)
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

