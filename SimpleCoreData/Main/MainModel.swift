//
//  MainModel.swift
//  SimpleCoreData
//
//  Created by Иван on 09.04.2023.
//

import Foundation

struct NoteItem: Identifiable{
    
    var id: UUID
    var title: String
    var text: String
}
