//
//  RadioPlayerApp.swift
//  RadioPlayer
//
//  Created by Leha on 04.09.2022.
//

import SwiftUI

@main
struct RadioPlayerApp: App {

    var network = NetworkManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
    
}
