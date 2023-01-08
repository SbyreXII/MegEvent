//
//  Speakers.swift
//  MegEvent
//
//  Created by user231763 on 06/01/2023.
//

import SwiftUI

struct SpeakerView: View {
    let speaker: Speakers

    var body: some View {
        VStack(alignment: .leading) {
            Text(speaker.fields.name).font(.title)
            Text(speaker.fields.company)
            Text(speaker.fields.role)
            Text(speaker.fields.email)
            Text(speaker.fields.phone)
            /*if (speaker.fields.viens) {
                Text("Present")
            }
            else {
                Text("Absent")
            }*/
        }
    }
}


struct ContentSpeakersView: View {
    @State var Speakers: [Speakers] = []

    var body: some View {
        NavigationView{
            List(Speakers, id: \.fields.name) { Speaker in
                SpeakerView(speaker: Speaker)
            }
            .onAppear(perform: getSpeakers)
            .navigationBarTitle("Speakers' info")
        }
        
    }

    func getSpeakers() {
        let requestFactory = RequestFactory()

        requestFactory.getSpeakersList { (error, Speakers) in
            if let Speakers = Speakers {
                self.Speakers = Speakers
            }
        }
    }
}

struct ContentViewSpeakers_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentSpeakersView()
                .environment(\.colorScheme, .dark)
                .previewLayout(.fixed(width: 300, height: 70))
            ContentSpeakersView()
                .environment(\.colorScheme, .light)
                .previewLayout(.fixed(width: 300, height: 70))
        }
    }
}

