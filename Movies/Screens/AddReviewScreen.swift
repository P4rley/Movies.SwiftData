//
//  AddReviewScreen.swift
//  Movies
//
//  Created by Adwitya Hersa on 14/03/25.
//

import SwiftUI
import SwiftData

struct AddReviewScreen: View {
    
    let movie: Movie
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var subject: String = ""
    @State private var description: String = ""
    
    private var isFormValid: Bool {
        !subject.isEmptyOrWhitespace && !description.isEmptyOrWhitespace
        
    }
    
    var body: some View {
        Form {
            TextField("Subject", text: $subject)
            TextField("Body", text: $description)
        }
        .navigationTitle("Add Review")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    
                    let review = Review(subject: subject, body: description)
                    
                    review.movie = movie
                    
                    context.insert(review)
                    
                    do {
                        try context.save()
                        movie.reviews.append(review)
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    dismiss()
                }
                .disabled(!isFormValid)
            }
        }
    }
}

//#Preview {
//    AddReviewScreen()
//}
