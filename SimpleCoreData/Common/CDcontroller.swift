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
    func fetchAll() -> [Note] {
        
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        
        do{
            return try viewContext.fetch(request)
        }
        catch{
            print("Retrieving fault.")
            return []
        }
    }
    
    //  Извлечение одного элемента(при нажатии)
    //  Функция не рациональна на малом объёме данных,
    //  Но на большом количестве записей с объёмными текстовыми полями
    //  может иметь смысл
    func retreiveOne(id: UUID) -> (String, String) {
        
        let item = findInStorage(id: id)
        return (item!.title ?? "", item!.text ?? "")
    }
    
    //  Добавление одного элемента
    func add(title: String, text: String){
        
        let note = Note(context: viewContext)
        
        note.id = UUID()
        note.title = title
        note.text = text
        
        save()
    }
    
    //  Удаление одного элемента
    func delete(id: UUID){
        
        if let objectForDeletion = findInStorage(id: id){
            viewContext.delete(objectForDeletion)
            save()
        }
    }
    
    //  Изменение одного элемента
    func change(id: UUID, newTitle: String, newText: String){
        
        let changebleElement = findInStorage(id: id)
        
        changebleElement?.setValue(newTitle, forKey: "title")
        changebleElement?.setValue(newText, forKey: "text")
        
        save()
    }
    
    
    
    
    //  Поиск элемента(вспомогательный метод)
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
    
    //  Сохранение(вспомогательный метод)
    func save(){
        
        do{
            try viewContext.save()
        }
        catch{
            print("Save fault.")
        }
    }
    
    
    func findNoteInList(findLine: String) -> [Note]{
        
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.predicate = NSPredicate(format: "title contains[c] '\(findLine)'")
        
        do{
            return try viewContext.fetch(request)
        }
        catch{
            print("Retrieving fault.")
            return []
        }
    }
    
}
