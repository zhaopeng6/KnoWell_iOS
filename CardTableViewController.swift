//
//  CardTableViewController.swift
//  KnoWell
//
//  Created by zhaopeng on 2/7/16.
//  Copyright © 2016 MickelStudios. All rights reserved.
//

import UIKit

class CardTableViewController: UITableViewController, UISearchBarDelegate {
    var cards = [Card]()
    var filteredCards = [Card]()
    var searchController: UISearchController!

    var shouldShowSearchResults: Bool = false

    // array of cards converted into groups
    var cardsGrouped = NSDictionary() as! [String : [Card]]

    // array of section titles
    var sectionTitleList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSearchController()

        definesPresentationContext = true

        // Load the contacts in the background
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { [unowned self] in
            self.cards = Card.getCurrentUserContacts()

            self.cards.sortInPlace({
                $0.firstName < $1.firstName
            })

            // split data into section
            self.splitDataInToSection()

            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.tableView.reloadData()
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here ..."
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        // tableView.tableHeaderView = searchController.searchBar

        self.searchController.hidesNavigationBarDuringPresentation = false;
        self.definesPresentationContext = false;

        // the UIViewController comes with a navigationItem property
        // this will automatically be initialized for you if when the
        // view controller is added to a navigation controller's stack
        // you just need to set the titleView to be the search bar
        navigationItem.titleView = searchController.searchBar

        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true

    }

    private func splitDataInToSection() {
        // Get the list we are interested in
        var currList : [Card]

        if searchController.active && searchController.searchBar.text != "" {
            currList = filteredCards
        } else {
            currList = cards
        }

        self.cardsGrouped.removeAll()
        self.sectionTitleList.removeAll()

        // set section title "" at initial
        var sectionTitle: String = ""

        // iterate all records from array
        for i in 0..<currList.count {

            // get current record
            let currentRecord = currList[i]

            // find first character from current record
            let firstChar = currentRecord.firstName[currentRecord.firstName.startIndex]

            // convert first character into string
            let firstCharString = "\(firstChar)"

            // if first character not match with past section title then create new section
            if firstCharString != sectionTitle {

                // set new title for section
                sectionTitle = firstCharString

                // add new section having key as section title and value as empty array of string
                self.cardsGrouped[sectionTitle] = [Card]()

                // append title within section title list
                self.sectionTitleList.append(sectionTitle)
            }

            // add record to the section
            self.cardsGrouped[firstCharString]?.append(currentRecord)
        }

    }

    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredCards = cards.filter { card in
            return card.firstName.lowercaseString.containsString(searchText.lowercaseString) ||
                searchText == ""
        }

        splitDataInToSection()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return cardsGrouped.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleList[section]
    }

    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return sectionTitleList
    }

    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return index
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // find section title
        let sectionTitle = self.sectionTitleList[section]

        // find card list for that section
        let cardlist = self.cardsGrouped[sectionTitle]

        // return count for fruits
        return cardlist!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CardTableViewCell", forIndexPath: indexPath) as! CardTableViewCell


        // Configure the cell...

        // find section title
        let sectionTitle = self.sectionTitleList[indexPath.section]

        // find card list for given section title
        let cardlist = self.cardsGrouped[sectionTitle]

        // find card based on the row within section
        let currentCard = cardlist?[indexPath.row]

        cell.nameField?.text = (currentCard?.firstName)! + " " + (currentCard?.lastName)!
        cell.firstDescField.text = currentCard?.company
        cell.secondDescField.text = currentCard?.city
        cell.imageField.image = currentCard?.portrait

        // return cell
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let card: Card
                if shouldShowSearchResults {
                    card = filteredCards[indexPath.row]
                } else {
                    card = cards[indexPath.row]
                }
                // Get the new view controller using segue.destinationViewController.
                let controller = segue.destinationViewController as! EditCardViewController

                // Pass the selected object to the new view controller.
                controller.toEditCard = card
            }
        }
    }

}

extension CardTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
}
