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
    case none
}

struct FilterSelectionScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var movieTitle: String = ""
    @State private var numberOfReviews: Int?
    
    @Binding var filterOption: FilterOption
    
    var body: some View {
        Form {
            Section("Filter by title") {
                TextField("Movie title", text: $movieTitle)
                Button("Search") {
                    filterOption = .title(movieTitle)
                    dismiss()
                }
            }
            
            Section("Filter by number of reviews") {
                TextField("Number of reviews", value: $numberOfReviews, format: .number)
                    .keyboardType(.numberPad)
                Button("Search") {
                    filterOption = .reviewsCount(numberOfReviews ?? 1)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    FilterSelectionScreen(filterOption: .constant(.title("Batman")))
}
