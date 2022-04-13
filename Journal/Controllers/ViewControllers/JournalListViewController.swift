//
//  JournalListViewController.swift
//  Journal
//
//  Created by Tasuku Yamamoto on 4/12/22.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    //MARK: - IBOutlets
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalListTableView: UITableView!
    @IBOutlet weak var createNewJournalButton: UIButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        journalListTableView.delegate = self
        journalListTableView.dataSource = self
        createNewJournalButton.isEnabled = false
        createNewJournalButton.alpha = 0.5
        JournalController.shared.loadDataFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createNewJournalButton.isEnabled = false
        createNewJournalButton.alpha = 0.5
        journalListTableView.reloadData()
    }
    
    //MARK: - IBActions
    @IBAction func createNewJournalButtonTapped(_ sender: Any) {
        guard let title = journalTitleTextField.text,
              !title.isEmpty else { return }
        JournalController.shared.createJournalWith(title: title)
        journalListTableView.reloadData()
        journalTitleTextField.text = ""
        createNewJournalButton.isEnabled = false
        createNewJournalButton.alpha = 0.5
    }
    
    //MARK: - Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalController.shared.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = journalListTableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        let journal = JournalController.shared.journals[indexPath.row]
        cell.textLabel?.text = journal.title
        if journal.entries.count == 1 {
            cell.detailTextLabel?.text = "1 Entry"
        }else{
            cell.detailTextLabel?.text = "\(journal.entries.count) Entries"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let journalToDelete = JournalController.shared.journals[indexPath.row]
            JournalController.shared.delete(journal: journalToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - TextField Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let text = (journalTitleTextField.text! as NSString).replacingCharacters(in: range, with: string)
    if text.isEmpty {
        createNewJournalButton.isEnabled = false
        createNewJournalButton.alpha = 0.5
    } else {
        createNewJournalButton.isEnabled = true
        createNewJournalButton.alpha = 1.0
    }
     return true
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        if segue.identifier == "toEntryList" {
            guard let indexPath = journalListTableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EntryListTableViewController else { return }
            let journalToSend = JournalController.shared.journals[indexPath.row]
            destination.journal = journalToSend
        }
    }
    

}
