//
//  Journal.swift
//  Journal
//
//  Created by Tasuku Yamamoto on 4/12/22.
//

import Foundation

class Journal: Codable {
    //MARK: - Properties
    let title: String
    var entries: [Entry]
    
    init(title: String, entries: [Entry] = []){
        self.title = title
        self.entries = entries
    }
    
}//End of class

extension Journal: Equatable{
    static func == (lhs: Journal, rhs: Journal) -> Bool{
        return lhs.title == rhs.title && lhs.entries == rhs.entries
    }
}//End of extension
