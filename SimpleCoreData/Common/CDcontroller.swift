//
//  CDcontroller.swift
//  SimpleCoreData
//
//  Created by Иван on 09.04.2023.
//

import Foundation
import CoreData


struct CDcontroller{
    
    static var shared = CDcontroller()
    var container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext
    
    
    init(){
        
        container = NSPersistentContainer(name: "NotesModel")
        
        container.loadPersistentStores{_, err in
            
            if let err = err as? NSError{
                print(err)
            }
        }
        
        viewContext = container.viewContext
    }
    
    
    func fetchAll() -> [NoteItem]{
        
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        
        var raw: [Note] = []
        var result: [NoteItem] = []
        
        do{
            try raw = viewContext.fetch(request)
        }
        catch{
            print("Retrieving fault.")
            return []
        }
        
        for item in raw{
            result.append(NoteItem(id: item.id!, title: item.title ?? "", text: item.text ?? ""))
        }
        
        return result
    }
    
    
    func add(title: String, text: String){
        
        let note = Note(context: viewContext)
        
        note.id = UUID()
        note.title = title
        note.text = text
        
        save()
    }
    
    func save(){
        
        do{
            try viewContext.save()
        }
        catch{
            print("Save failed.")
        }
    }
    
}
