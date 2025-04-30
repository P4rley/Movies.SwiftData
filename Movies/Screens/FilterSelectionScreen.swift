//
//  FilterSelectionScreen.swift
//  Movies
//
//  Created by Adwitya Hersa on 24/04/25.
//

import SwiftUI

enum FilterOption {
    case title(String)
    case reviewsCount(Int)
    case actorsCount(Int)
    case genre(Genre)
    case none
}

struct FilterSelectionScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var filterSelectionConfig: FilterSelectionConfig
    
    var body: some View {
        Form {
            Section("Filter by title") {
                TextField("Movie title", text: $filterSelectionConfig.movieTitle)
                Button("Search") {
                    filterSelectionConfig.filter = .title(filterSelectionConfig.movieTitle)
                    dismiss()
                }
            }
            
            Section("Filter by number of reviews") {
                TextField("Number of reviews", value: $filterSelectionConfig.numberOfReviews, format: .number)
                    .keyboardType(.numberPad)
                Button("Search") {
                    filterSelectionConfig.filter = .reviewsCount(filterSelectionConfig.numberOfReviews ?? 1)
                    dismiss()
                }
            }
            
            Section("Filter by number of actors") {
                TextField(
                    "Number of actors",
                    value: $filterSelectionConfig.numberOfActors,
                    format: .number
                )
                    .keyboardType(.numberPad)
                Button("Search") {
                    filterSelectionConfig.filter = .actorsCount(filterSelectionConfig.numberOfActors ?? 1)
                    dismiss()
                }
            }
            
            Section("Filter by genre") {
                Picker("Select a genre", selection: $filterSelectionConfig.genre) {
                    ForEach(Genre.allCases) { genre in
                        Text(genre.title).tag(genre)
                    }
                }.onChange(of: filterSelectionConfig.genre) {
                    filterSelectionConfig.filter = .genre(filterSelectionConfig.genre)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    FilterSelectionScreen(filterSelectionConfig: .constant(FilterSelectionConfig()))
}
