//
//  DatabaseSwift.swift
//  xSwiftlib
//
//  Created by pwrd on 2023/5/1.
//

import Foundation
import WCDBSwift

class DatabaseSwift {
    static let shared = DatabaseSwift()
    private init() {}
    
    let database = Database(withPath: NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).last! + "/xSwiftlib.db")
    
    func createTables() {
        do {
            try database.create(table: "learnt_table_swift", of: LearntWordSwift.self)
        }
        catch {}
    }
    
}
        
