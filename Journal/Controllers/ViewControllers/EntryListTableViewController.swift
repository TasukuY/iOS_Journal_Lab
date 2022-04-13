//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Tasuku Yamamoto on 4/11/22.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    //MARK: - Properties
    var journal: Journal?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journal?.entries.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        guard let journal = journal else { return cell }
        
        let entry = journal.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.stringTimestamp
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let journal = journal else { return }
            let entryToDelete = journal.entries[indexPath.row]
            EntryController.delete(entry: entryToDelete, journal: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO Identifier, IndexPath, Destination, Object to send, Object to Recieve
        if segue.identifier == "entryCellToEntryDetailView" {
            guard let journalToSend = journal,
                  let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EntryDetailViewController else { return }
            let entryToSend = journalToSend.entries[indexPath.row]
            destination.entry = entryToSend
            destination.journal = journalToSend
        }else if segue.identifier == "createNewEntry" {
            guard let journalToSend = journal,
                  let destination = segue.destination as? EntryDetailViewController else { return }
            destination.journal = journalToSend
        }
    }
    

}
