//
//  AddMovieScreen.swift
//  Movies
//
//  Created by Adwitya Hersa on 13/03/25.
//

import SwiftUI
import SwiftData

struct AddMovieScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var title: String = ""
    @State private var year: Int?
    @State private var selectedActors: Set<Actor> = []
    @State private var genre: Genre = .action
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhitespace && year != nil && !selectedActors.isEmpty
    }
    
    var body: some View {
        Form {
            
            Picker("Select Genre", selection: $genre) {
                ForEach(Genre.allCases) { genre in
                    Text(genre.title).tag(genre)
                }
            }
            .pickerStyle(.segmented)
            
            TextField("Title", text: $title)
            TextField("Year", value: $year, format: .number)
            
            Section("Select Actors") {
                ActorSelectionView(selectedActors: $selectedActors)
            }
        }
        .navigationTitle("Add Movie")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    
                    guard let year = year else { return }
                    
                    let movie = Movie(name: title, year: year, genre: genre)
                    movie.actors = Array(selectedActors)
                    
                    selectedActors.forEach { actor in
                        actor.movies.append(movie)
                        context.insert(actor)
                    }
                    
                    context.insert(movie)
                    
                    do {
                        try context.save()
                       
                    } catch {
                        print("Error saving: \(error.localizedDescription)")
                    }
                    
                    dismiss()
                }
                .disabled(!isFormValid)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddMovieScreen()
            .modelContainer(for: [Movie.self])
    }
}
