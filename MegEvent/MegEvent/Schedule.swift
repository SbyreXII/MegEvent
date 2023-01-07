//
//  Schedule.swift
//  MegEvent
//
//  Created by user231763 on 06/01/2023.
//

import SwiftUI

struct ScheduleView: View {
    let schedule: Schedule

    var body: some View {
        VStack(alignment: .leading) {
            Text(schedule.fields.name).font(.title)
            Text(schedule.fields.type)
            Text(schedule.fields.location)
            Text(schedule.fields.debut)
            Text(schedule.fields.fin)
            /*ForEach(schedule.fields.speakers!, id: \.self) { item in
                //Text(GetSpeakersFromSchedule(id: item))
                Text(item)
            }*/
            if let notes = schedule.fields.notes {
                Text(notes)
            }
        }
    }
}

struct ContentScheduleView: View {
    @State var schedules: [Schedule] = []

    var body: some View {
        List(schedules, id: \.fields.name) { schedule in
            ScheduleView(schedule: schedule )
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
