//
//  ActorCellView.swift
//  Movies
//
//  Created by Adwitya Hersa on 24/04/25.
//

import SwiftUI

struct ActorCellView: View {
    
    let actor: Actor
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(actor.name)
            Text(actor.movies.map { $0.name }, format: .list(type: .and))
                .font(.caption)
        }
        
    }
}
