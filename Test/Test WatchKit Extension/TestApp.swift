//
//  TestApp.swift
//  Test WatchKit Extension
//
//  Created by Peter Victoratos on 6/23/20.
//

import SwiftUI

@main
struct TestApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
