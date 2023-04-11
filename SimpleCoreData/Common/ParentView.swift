//
//  ContentView.swift
//  SimpleCoreData
//
//  Created by Иван on 09.04.2023.
//

import SwiftUI

struct ParentView: View {

    @ObservedObject var mainEditVM = MainEditVM()
    
    var body: some View {
        switch mainEditVM.currentScreen{
            
        case "main": MainView(mainEditVM: mainEditVM)
        case "editor": EditView(mainEditVM: mainEditVM)
            
        default: MainView(mainEditVM: mainEditVM)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}
