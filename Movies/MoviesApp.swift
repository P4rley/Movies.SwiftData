//
//  MoviesApp.swift
//  Movies
//
//  Created by Adwitya Hersa on 13/03/25.
//

import SwiftUI
import SwiftData

@main
struct MoviesApp: App {
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(
                for: Movie.self,
                migrationPlan: MoviesMigrationPlan.self,
                configurations: ModelConfiguration(for: Movie.self)
            )
        } catch {
            fatalError("Could not initialize the container.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MovieListScreen()
            }
        }
        .modelContainer(container)
    }
}
