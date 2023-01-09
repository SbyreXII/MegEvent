//
//  Schedule.swift
//  MegEvent
//
//  Created by user231763 on 06/01/2023.
//

import SwiftUI

struct ScheduleDayTwo: View {
    let schedule: Schedule
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView{
                Text(schedule.fields.name).font(.title)
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 2)
                Text("Type : " + schedule.fields.type)
                Text("Location : " + schedule.fields.location)
                let stringDebut = schedule.fields.debut
                let subStringDebut = stringDebut[stringDebut.index(stringDebut.startIndex, offsetBy: 11)..<stringDebut.index(stringDebut.startIndex, offsetBy: 16)]
                let stringFin = schedule.fields.fin
                let subStringFin = stringFin[stringFin.index(stringFin.startIndex, offsetBy: 11)..<stringFin.index(stringFin.startIndex, offsetBy: 16)]
                Text(subStringDebut + " - " + subStringFin)
                /*ForEach(schedule.fields.speakers!, id: \.self) { item in
                    //Text(GetSpeakersFromSchedule(id: item))
                    Text(item)
                }*/
                if let notes = schedule.fields.notes {
                    Text("\n" + notes)
                        .font(.custom("Helvetica-LightOblique",size: 14))
                }
            }
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
    }
}

struct ContentScheduleViewDayTwo: View {
    @State var schedules: [Schedule] = []
    
    var body: some View {
        NavigationView{
            List(schedules.filter { !$0.fields.debut.contains("-08") }.sorted(by: { $0.fields.debut < $1.fields.debut}), id: \.fields.name) { item in NavigationLink(destination: DetailView(schedule: item)){                ScheduleView(schedule: item )
            }}
            .navigationBarTitle("Schedule of Day Two")
            .onAppear(perform: getSchedules)
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

struct ContentViewSchedule_PreviewsDayTwo: PreviewProvider {
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


