//
//  MainView.swift
//  SimpleCoreData
//
//  Created by Иван on 09.04.2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var mainEditVM: MainEditVM
    
    var body: some View {
        VStack{
            HStack{
                Text("Заметки")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
                
                Button(action: {mainEditVM.clickPlus()}, label: {
                    Text("+")
                        .font(.system(size: 35, weight: .light))
                })
                .padding(.trailing, 20)
            }
            
            tf(placeHolder: "Поиск", txt: $mainEditVM.findLine, w: .infinity, h: 60)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            
            ScrollView(.vertical){
                VStack{
                    
                    ForEach(mainEditVM.itemsPreview){item in
                        oneNoteItem(mainVM: mainEditVM, id: item.id!, title: item.title ?? "Ошибка")
                    }
                }
                .padding(.top, 10)
            }
            
            
        }
        .onAppear{mainEditVM.retreiveAll()}
    }
}


struct oneNoteItem: View{
    
    @ObservedObject var mainVM: MainEditVM
    
    var id: UUID
    var title: String
    
    var body: some View{
        
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
            
            HStack{
                Text(title)
                    .padding(.leading, 20)
                
                Spacer()
                
                Button(action: {mainVM.itemDelete(id: id)}, label: {
                    Image(systemName: "trash")
                        .foregroundColor(Color.red)
                })
                    .padding(.trailing, 20)
            }
        }
        .frame(maxWidth: .infinity, idealHeight: 50)
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .onTapGesture {
            mainVM.itemClick(id: id)
        }
    }
}
