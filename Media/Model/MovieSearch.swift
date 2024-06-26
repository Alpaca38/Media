//
//  MovieSearch.swift
//  Media
//
//  Created by 조규연 on 6/11/24.
//

import Foundation

struct SearchMovie: Codable {
    let page: Int
    var results: [SearchResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct SearchResult: Codable {
    let poster_path: String?
    let id: Int
    let original_title: String
    let overview: String
}
