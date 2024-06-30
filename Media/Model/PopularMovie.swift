//
//  PopularMovie.swift
//  Media
//
//  Created by 조규연 on 6/30/24.
//

import Foundation

struct PopularMovie: Decodable {
    let page: Int
    let results: [MovieListResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
