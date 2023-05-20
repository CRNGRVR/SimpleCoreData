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
    
    @Published var itemsPreview: [Note] = []
    @Published var findLine: String = ""{
        didSet{
            if findLine != ""{
                itemsPreview = CDcontroller.shared.findNoteInList(findLine: findLine)
            }
            else{
                itemsPreview = CDcontroller.shared.fetchAll()
            }
        }
    }
    
    
    var isNew = false
    var currentOpenNote: UUID? = nil
    @Published var titleInEditor = ""
    @Published var textInEditor = ""
    
    
    
    func add(title: String, text: String){
        
        CDcontroller.shared.add(title: title, text: text)
        retreiveAll()
    }
    
    
    func retreiveAll(){
        itemsPreview = CDcontroller.shared.fetchAll()
    }
    
    
    func itemClick(id: UUID){
        currentOpenNote = id
        
        let one = CDcontroller.shared.retreiveOne(id: id)
        titleInEditor = one.0
        textInEditor = one.1
        
        currentScreen = "editor"
    }
    
    
    func itemDelete(id: UUID){
        CDcontroller.shared.delete(id: id)
        
        //  Повторная отрисовка
        retreiveAll()
    }
    
    
    func clickBack(){
        
        currentScreen = "main"
        
        titleInEditor = ""
        textInEditor = ""
        
        isNew = false
        currentOpenNote = nil
    }
    
    func clickSave(id: UUID?){
        
        if isNew{
            add(title: titleInEditor, text: textInEditor)
        }
        else{
            
            //  Редактирование уже имеющейся в бд заметки
            CDcontroller.shared.change(id: id!, newTitle: titleInEditor, newText: textInEditor)
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
