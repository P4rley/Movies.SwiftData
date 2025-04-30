//
//  MoviesMigrationPlan.swift
//  Movies
//
//  Created by Adwitya Hersa on 29/04/25.
//

import Foundation
import SwiftData

enum MoviesMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [
            MovieSchemaV1.self,
            MovieSchemaV2.self,
            MovieSchemaV3.self,
            MovieSchemaV4.self
        ]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2, migrateV2toV3, migrateV3toV4]
    }
    
    static let migrateV1toV2 = MigrationStage.custom(
        fromVersion: MovieSchemaV1.self,
        toVersion: MovieSchemaV2.self,
        willMigrate: {
            context in
            
            guard let movies = try? context.fetch(FetchDescriptor<Movie>()) else { return }
            
            var duplicates = Set<Movie>()
            var uniqueSet = Set<String>()
            
            for movie in movies {
                if !uniqueSet.insert(movie.name).inserted {
                    duplicates.insert(movie)
                }
            }
            
            for movie in duplicates {
                guard let movieToBeUpdated = movies.first(where: { $0.id == movie.id }) else {
                    continue
                }
                
                movieToBeUpdated.name = movieToBeUpdated.name + "\(UUID().uuidString)"
            }
            
            try? context.save()
        },
        didMigrate: nil
    )
    
    static let migrateV2toV3 = MigrationStage.lightweight(
        fromVersion: MovieSchemaV2.self,
        toVersion: MovieSchemaV3.self
    )
    
    static let migrateV3toV4 = MigrationStage.lightweight(
        fromVersion: MovieSchemaV3.self,
        toVersion: MovieSchemaV4.self
    )
}
