//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Tasuku Yamamoto on 4/11/22.
//

import UIKit

class EntryDetailViewController: UIViewController {
    //MARK: - Properties
    var entry: Entry?
    var journal: Journal?
    
    //MARK: - IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var entryTextView: UITextView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
        //Hide Keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

    //MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let entry = self.entry {
            guard let title = titleTextField.text,
                  let body = entryTextView.text else { return }
            EntryController.update(entry: entry, title: title, body: body)
        }else{
            guard let title = titleTextField.text,
                  let body = entryTextView.text,
                  let journal = self.journal else { return }
                EntryController.createEntryWith(title: title, body: body, journal: journal)
        }
        navigationController?.popViewController(animated: true)
        /*
        If you want to go back to the previous view controller:
            navigationController?.popViewControllerAnimated(true)
        If you want to go back to the root view controller:
            navigationController?.popToRootViewControllerAnimated(true)
        */
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        entryTextView.text = ""
    }
    
    //MARK: - Methods
    func updateView(){
        guard let entry = self.entry else { return }
        titleTextField.text = entry.title
        entryTextView.text = entry.body
    }
    
}//End of class

