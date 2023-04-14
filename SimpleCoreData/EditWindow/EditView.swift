//
//  EditView.swift
//  SimpleCoreData
//
//  Created by Иван on 09.04.2023.
//

import SwiftUI

struct EditView: View {
    
    @ObservedObject var mainEditVM: MainEditVM
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {mainEditVM.clickBack()}, label: {
                    Text("Назад")
                })
                .padding(.leading, 20)
                
                Spacer()
                
                Button(action: {mainEditVM.clickSave(id: mainEditVM.currentOpenNote)}, label: {
                    Text("Сохранить")
                        .foregroundColor(Color.yellow)
                })
                .padding(.trailing, 20)
            }
            
            tf(placeHolder: "Заголовок", txt: $mainEditVM.titleInEditor, w: .infinity, h: 60)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            
            te(txt: $mainEditVM.textInEditor, w: .infinity, h: .infinity)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            
            
        }
    }
}

struct tf: View{
    
    var placeHolder: String
    @Binding var txt: String
    
    var w: CGFloat
    var h: CGFloat
    
    var body: some View{
        ZStack{
            Color("tf")
                .cornerRadius(10)
            
            TextField(placeHolder, text: $txt)
                .frame(maxWidth: .infinity, maxHeight: .infinity , alignment: .topLeading)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.top, 20)
        }
        .frame(maxWidth: w, maxHeight: h)
    }
}

struct te: View{

    @Binding var txt: String
    
    var w: CGFloat
    var h: CGFloat
    
    var body: some View{
        ZStack{
            Color("tf")
                .cornerRadius(10)
            
            TextEditor(text: $txt)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .foregroundColor(Color.black)
                .frame(maxWidth: .infinity, maxHeight: .infinity , alignment: .topLeading)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.top, 20)
        }
        .frame(maxWidth: w, maxHeight: h)
    }
}
