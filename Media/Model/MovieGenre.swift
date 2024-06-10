//
//  MovieGenre.swift
//  Media
//
//  Created by 조규연 on 6/10/24.
//

import Foundation

// MARK: - GenreList
struct GenreList: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
    
    var genreString: String {
        return "#\(name)"
    }
}
