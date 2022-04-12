//
//  JournalController.swift
//  Journal
//
//  Created by Tasuku Yamamoto on 4/12/22.
//

import Foundation

class JournalController {
    //MARK: - Properties
    static let shared = JournalController()
    
    //MARK: - Source of Truth
    var journals: [Journal] = []
    
    //MARK: - CRUD funcs
    func createJournalWith(title: String){
        let newJournal = Journal(title: title)
        journals.append(newJournal)
        saveDataToPersistenceStore()
    }
    
    func delete(journal: Journal){
        guard let index = journals.firstIndex(of: journal) else { return }
        journals.remove(at: index)
        saveDataToPersistenceStore()
    }
    
    func addEntryTo(journal: Journal, title: String, body: String){
        let today = Date()
        let newEntry = Entry(journalTitle: title, journalBody: body, dayOf: today)
        journal.entries.append(newEntry)
        saveDataToPersistenceStore()
    }
    
    func removeEntryFrom(journal: Journal, entry: Entry){
        guard let index = journal.entries.firstIndex(of: entry) else { return }
        journal.entries.remove(at: index)
        saveDataToPersistenceStore()
    }
    
    //MARK: - Persistence
    //Persistence Store/location of the date
    func persistentStore() -> URL {
        //default is a singelton/shared object of filemanager
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Journal.json")
        return fileURL
    }
    
    //Save data
    func saveDataToPersistenceStore() {
        do{
            let data = try JSONEncoder().encode(journals)
            try data.write(to: persistentStore())
        }catch {
            print("We had an error saving to our persistence store")
            print("Encoding Error \(error)")
            print(error.localizedDescription)
        }
    }
    
    //Load data
    func loadDataFromPersistenceStore() {
        do{
            let data = try Data(contentsOf: persistentStore())
            journals = try JSONDecoder().decode([Journal].self, from: data)
        }catch{
            print("We had an error loading our data from the persistence store")
            print("Decoding Error \(error)")
            print(error.localizedDescription)
        }
    }
    
}//End of class
