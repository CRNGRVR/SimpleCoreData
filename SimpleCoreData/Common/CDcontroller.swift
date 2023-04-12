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
    
    //  Извлечение всех данных
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
    
    //  Добавление одного элемента
    func add(title: String, text: String){
        
        let note = Note(context: viewContext)
        
        note.id = UUID()
        note.title = title
        note.text = text
        
        save()
    }
    
    
    func delete(id: UUID){
        
        if let objectForDeletion = findInStorage(id: id){
            
            viewContext.delete(objectForDeletion)
        }
    }
    
    func findInStorage(id: UUID) -> Note?{
        
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.predicate = NSPredicate(format: "id = '\(id)'")
        
        do {
            return try viewContext.fetch(request)[0]    //  Предполагается, что такое значение одно
        } catch {
            print("Find fault.")
            return nil
        }
    }
    
    //  Сохранение
    func save(){
        
        do{
            try viewContext.save()
        }
        catch{
            print("Save failed.")
        }
    }
    
}
