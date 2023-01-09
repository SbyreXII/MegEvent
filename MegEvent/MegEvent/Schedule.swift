//
//  Schedule.swift
//  MegEvent
//
//  Created by user231763 on 06/01/2023.
//

import SwiftUI

struct ScheduleView: View {
    let schedule: Schedule
    
    @State private var showDetailView = false

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView{
                Text(schedule.fields.name).font(.title)
                    .foregroundColor(Color(UIColor.systemTeal))
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 2)
                //Text("Type : " + schedule.fields.type)
                //Text("Location : " + schedule.fields.location)
                let stringDebut = schedule.fields.debut
                let subStringDebut = stringDebut[stringDebut.index(stringDebut.startIndex, offsetBy: 11)..<stringDebut.index(stringDebut.startIndex, offsetBy: 16)]
                let stringFin = schedule.fields.fin
                let subStringFin = stringFin[stringFin.index(stringFin.startIndex, offsetBy: 11)..<stringFin.index(stringFin.startIndex, offsetBy: 16)]
                let timer = subStringDebut + " - " + subStringFin
                Text(timer)
                /*ForEach(schedule.fields.speakers!, id: \.self) { item in
                    //Text(GetSpeakersFromSchedule(id: item))
                    Text(item)
                }*/
                
                let name = schedule.fields.name as String
                let notes = schedule.fields.notes
                let category = schedule.fields.type as String
                let location = schedule.fields.location as String
                let time = String(timer)
                
                Button(action: {self.showDetailView = true}){Text("\nShow Detail")}
                    .sheet(isPresented: $showDetailView){DetailView(notes: notes, category: category, location: location, name: name, time: time )}
                /*if let notes = schedule.fields.notes {
                    Text("\n" + notes)
                        .font(.custom("Helvetica-LightOblique",size: 14))
                }*/
            }
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
        .background(Color(UIColor.systemBackground))
        .shadow(radius: 10)
        .transition(.slide)
    }
}

struct ContentScheduleView: View {
    @State var schedules: [Schedule] = []
    
    var body: some View {
        NavigationView{
            List(schedules.filter { !$0.fields.debut.contains("-09") }.sorted(by: { $0.fields.debut < $1.fields.debut}), id: \.fields.name) { schedule in
                ScheduleView(schedule: schedule )
            }
            .onAppear(perform: getSchedules)
            .navigationBarTitle("Home Page : First Day")
            .navigationBarItems(trailing:
            HStack{
                NavigationLink(destination: ContentSpeakersView()){
                    Text("Speakers' List")}
                NavigationLink(destination:ContentScheduleViewDayTwo()){
                    Text("                                     Day Two")
                }
            }
            )
        }
    }

    func getSchedules() {
        let requestFactory = RequestFactory()

        requestFactory.getScheduleList { (error, schedules) in
            if let schedules = schedules {
                self.schedules = schedules
            }
        }
    }
}

struct ContentViewSchedule_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentScheduleView()
                .environment(\.colorScheme, .dark)
                .previewLayout(.fixed(width: 300, height: 70))
            ContentScheduleView()
                .environment(\.colorScheme, .light)
                .previewLayout(.fixed(width: 300, height: 70))
        }
    }
}


