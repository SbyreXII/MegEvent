//
//  SwiftUIView.swift
//  MegEvent
//
//  Created by user231590 on 09/01/2023.
//

import SwiftUI

struct DetailView: View {
    
    @State private var showDetailView = false
    
    var schedule: Schedule
    
    var body: some View {
        VStack{
            Text("\nDetail Activity\n")
                .font(.largeTitle)
            Text(schedule.fields.name)
                .font(.largeTitle)
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 2)
            
            let stringDebut = schedule.fields.debut
            let subStringDebut = stringDebut[stringDebut.index(stringDebut.startIndex, offsetBy: 11)..<stringDebut.index(stringDebut.startIndex, offsetBy: 16)]
            let stringFin = schedule.fields.fin
            let subStringFin = stringFin[stringFin.index(stringFin.startIndex, offsetBy: 11)..<stringFin.index(stringFin.startIndex, offsetBy: 16)]
            let timer = subStringDebut + " - " + subStringFin
            Text("\nTime : " + timer)
            Text("\n" + "Type : " + schedule.fields.type)
            Text("\n Location : " + schedule.fields.location)
            
            if let notes = schedule.fields.notes {
                Text("\n" + notes)
                .font(.custom("Helvetica-LightOblique",size: 14))
            }
                
            Button(action: {self.showDetailView = true}){Text("\nHideDetail\n")}
                .sheet(isPresented: $showDetailView){ContentScheduleView()}
        }
        .cornerRadius(10)
        .background(Color(UIColor.systemBackground))
        .shadow(radius: 10)
        .transition(.slide)
    }
}

/*struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}*/
