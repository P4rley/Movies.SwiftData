//
//  MoviesSchemaVersions.swift
//  Movies
//
//  Created by Adwitya Hersa on 29/04/25.
//

import Foundation
import SwiftData

enum MovieSchemaV1: VersionedSchema {
    
    static var models: [any PersistentModel.Type] {
        [Movie.self]
    }
    
    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)

    @Model
        final class Movie {
            var title: String
            var year: Int

            @Transient
            var reviewsCount: Int {
                reviews.count
            }

            @Transient
            var actorsCount: Int {
                actors.count
            }

            @Relationship(deleteRule: .cascade, inverse: \Review.movie)
            var reviews: [Review] = []

            @Relationship(deleteRule: .noAction, inverse: \Actor.movies)
            var actors: [Actor] = []

            init(title: String, year: Int) {
                self.title = title
                self.year = year
            }
        }
}

enum MovieSchemaV2: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(2, 0, 0)

    static var models: [any PersistentModel.Type] {
        [Movie.self]
    }
    
    @Model
        final class Movie {
            
            @Attribute(.unique) var title: String
            var year: Int

            @Transient
            var reviewsCount: Int {
                reviews.count
            }

            @Transient
            var actorsCount: Int {
                actors.count
            }

            @Relationship(deleteRule: .cascade, inverse: \Review.movie)
            var reviews: [Review] = []

            @Relationship(deleteRule: .noAction, inverse: \Actor.movies)
            var actors: [Actor] = []

            init(title: String, year: Int) {
                self.title = title
                self.year = year
            }
        }
}

enum MovieSchemaV3: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(3, 0, 0)

    static var models: [any PersistentModel.Type] {
        [Movie.self]
    }
    
    @Model
        final class Movie {
            
            @Attribute(.unique, originalName: "title") var name: String
            var year: Int

            @Transient
            var reviewsCount: Int {
                reviews.count
            }

            @Transient
            var actorsCount: Int {
                actors.count
            }

            @Relationship(deleteRule: .cascade, inverse: \Review.movie)
            var reviews: [Review] = []

            @Relationship(deleteRule: .noAction, inverse: \Actor.movies)
            var actors: [Actor] = []

            init(name: String, year: Int) {
                self.name = name
                self.year = year
            }
        }
}

