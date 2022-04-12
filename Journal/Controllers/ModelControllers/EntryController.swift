//
//  EntryController.swift
//  Journal
//
//  Created by Tasuku Yamamoto on 4/11/22.
//

import Foundation

class EntryController {
    
    //MARK: - CRUD Methods
    static func createEntryWith(title: String, body: String, journal: Journal){
        JournalController.shared.addEntryTo(journal: journal, title: title, body: body)
    }
    
    static func delete(entry: Entry, journal: Journal){
        JournalController.shared.removeEntryFrom(journal: journal, entry: entry)
    }
    
}//End of class
