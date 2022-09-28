//
//  MovieListResponseModel.swift
//  Recommend
//
//  Created by Ishank Soni on 20/09/22.
//

import Foundation

// MARK: - Welcome
struct MovieListResponseModel: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int
    

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let title: String
    let popularity: Double
    let posterPath: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id, title
        case popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}
