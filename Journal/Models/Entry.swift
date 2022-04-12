//
//  Entry.swift
//  Journal
//
//  Created by Tasuku Yamamoto on 4/11/22.
//

import Foundation

class Entry: Equatable, Codable {
    //MARK: - Properties
    var title: String
    var body: String
    var timestamp: Date
    var stringTimestamp: String
    
    //MARK: - initializer
    init(journalTitle title: String, journalBody body: String, dayOf timestamp: Date){
        self.title = title
        self.body = body
        self.timestamp = timestamp
        let format = DateFormatter()
        format.dateFormat = "EEEE, MMM d, yyyy"
        stringTimestamp = format.string(from: timestamp)
    }
    
    //MARK: - Methods
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.body == rhs.body && lhs.timestamp == rhs.timestamp
    }
}//End of class

//extension Entry: Equatable{
//    static func ==(lhs: Entry, rhs: Entry) -> Bool{
//        return lhs.title == rhs.title && lhs.body == rhs.body && lhs.timestamp == rhs.timestamp
//    }
//}

