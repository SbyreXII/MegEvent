//
//  SwiftUIView.swift
//  MegEvent
//
//  Created by user231590 on 09/01/2023.
//

import SwiftUI

struct DetailView: View {
    
    @State private var showDetailView = false
    
    var notes: String?
    var category: String
    var location: String
    var name: String
    var time: String
    
    var body: some View {
        VStack{
            Text(name)
            Text(category)
            Text(time)
            Text(location)
            Text(notes!)
            
            Button(action: {self.showDetailView = true}){Text("\nHideDetail")}
                .sheet(isPresented: $showDetailView){ContentScheduleView()}
            
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(notes: "a", category: "b", location: "c", name: "d", time: "e")
    }
}
