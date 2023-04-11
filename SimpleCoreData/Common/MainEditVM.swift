//
//  MainVM.swift
//  SimpleCoreData
//
//  Created by Иван on 09.04.2023.
//

import Foundation
import CoreData

class MainEditVM: ObservableObject{
    
    //  Разместил тут полей и методов на три отдельные VM
    //  Я тут не на архитектуру тренируюсь :)
    //
    //  Ну реально, я с бд меньше работаю чем с архитектурой и View
    //  ...в проекте, посвящённому бд
    
    @Published var currentScreen = "main"
    
    @Published var itemsPreview: [NoteItem] = []
    
    var isNew = false
    @Published var titleInEditor = ""
    @Published var textInEditor = ""
    
    
    
    func add(title: String, text: String){
        
        CDcontroller.shared.add(title: title, text: text)
        retreiveAll()
    }
    
    func change(){
        
        
        
        retreiveAll()
    }
    
    func retreiveAll(){
        itemsPreview = CDcontroller.shared.fetchAll()
    }
    
    
    func itemClick(id: UUID){
        print("clck")
    }
    
    
    func itemDelete(id: UUID){
        print("deleted")
    }
    
    
    func clickBack(){
        
        currentScreen = "main"
        
        titleInEditor = ""
        textInEditor = ""
        
        isNew = false
    }
    
    func clickSave(){
        
        if isNew{
            add(title: titleInEditor, text: textInEditor)
        }
        else{
            
        }
        
        isNew = false
    }
    
    func goToEditor(id: UUID?){
        
        currentScreen = "editor"
        
        if id != nil{
            
        }
    }
    
    func clickPlus(){
        
        isNew = true
        goToEditor(id: nil)
    }
    
}
