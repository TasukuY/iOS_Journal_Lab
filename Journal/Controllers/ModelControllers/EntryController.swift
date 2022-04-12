//
//  EntryController.swift
//  Journal
//
//  Created by Tasuku Yamamoto on 4/11/22.
//

import Foundation

class EntryController {
    //MARK: - Properties
    static let shared = EntryController()
    
    //MARK: - Source of Truth
    var entries: [Entry] = []
    
    //MARK: - CRUD Methods
    func createEntryWith(title: String, body: String){
        let today = Date()
        let newEntry = Entry(journalTitle: title, journalBody: body, dayOf: today)
        entries.append(newEntry)
        saveDataToPersistenceStore()
    }
    
    func delete(entry: Entry){
        guard let index = entries.firstIndex(of: entry) else { return }
        entries.remove(at: index)
        saveDataToPersistenceStore()
    }
    
    //MARK: - Persistence
    //Persistence Store/location of the date
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
        return documentsDirectoryURL
    }
    
    //Save data
    func saveDataToPersistenceStore(){
        do{
            let data = try JSONEncoder().encode(entries)
            try data.write(to: fileURL())
        }catch{
            print("We have an error saving data to the persistence store")
            print("Encoding Error \(error)")
            print(error.localizedDescription)
        }
    }
    
    //Load data
    func loadDataFromPersistenceStore(){
        do{
            let data = try Data(contentsOf: fileURL())
            entries = try JSONDecoder().decode([Entry].self, from: data)
        }catch{
            print("We have an error loading data from the persistence store")
            print("Decoding error \(error)")
            print(error.localizedDescription)
        }
    }
    
    
}//End of class
