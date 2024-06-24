//
//  SimilarMovie.swift
//  Media
//
//  Created by 조규연 on 6/24/24.
//

import Foundation

struct SimilarMovie: Codable {
    let page: Int
    let results: [SimilarMovieResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct SimilarMovieResult: Codable {
    let originalTitle: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case posterPath = "poster_path"
    }
}
