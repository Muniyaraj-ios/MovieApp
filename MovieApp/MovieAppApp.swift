//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by ihub on 18/11/25.
//

import SwiftUI

@main
struct MovieAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabbarView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
