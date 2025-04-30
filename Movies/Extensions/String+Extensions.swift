//
//  String+Extensions.swift
//  Movies
//
//  Created by Adwitya Hersa on 13/03/25.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
