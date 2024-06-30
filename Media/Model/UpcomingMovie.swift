//
//  UpcomingMovie.swift
//  Media
//
//  Created by 조규연 on 6/30/24.
//

import Foundation

struct UpcomingMovie: Decodable {
    let dates: Dates
    let page: Int
    let results: [MovieListResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Dates: Decodable {
    let maximum, minimum: String
}

struct MovieListResult: Decodable, PosterData {
    let poster_path: String
    
    var path: String? {
        return poster_path
    }
}
