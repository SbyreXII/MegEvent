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
                // affiche les speakers des schedules mais on a rencontré des problèmes lié à getSpeakersFromSchedule() qui est asynchrone
                            // On s'est rendu compte que SwiftUI n'aime pas les appels direct à des fonctions asynchrones
                            // Du coup on a essayé de passer par des fonctions intermédiaires pour stocker la valeur des

                            /*if let speakers = schedule.fields.speakers {
                                ForEach(speakers, id: .self) { item in
                                    Text("Speaker : " + getSpeakerName(idSpeaker: item))
                                }
                            }*/
                
                /*if let notes = schedule.fields.notes {
                    Text("\n" + notes)
                        .font(.custom("Helvetica-LightOblique",size: 14))
                }*/
            }
        }
        .padding()
        .background(Color.white)
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
            List(schedules.filter { !$0.fields.debut.contains("-09") }.sorted(by: { $0.fields.debut < $1.fields.debut}), id: \.fields.name) { item in NavigationLink(destination: DetailView(schedule: item)){
                ScheduleView(schedule: item )
            }}
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
        .onAppear(perform: getSchedules)
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


