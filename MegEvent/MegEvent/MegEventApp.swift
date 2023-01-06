//
//  MegEventApp.swift
//  MegEvent
//
//  Created by user231590 on 12/12/2022.
//

import SwiftUI

@main
struct MegEventApp: App {
    var body: some Scene {
        WindowGroup {
            ContentScheduleView()
            ContentSpeakersView()
        }
    }
}
