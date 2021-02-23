//
//  MovieListResponse.swift
//  Movien
//
//  Created by Işıl Aktürk on 21.02.2021.
//

import Foundation

struct MovieList: Codable {
    let page: Int
    let results: [MovieDetail]
    let total_pages: Int
    let total_results: Int
}

struct MovieDetail: Codable {
    let id: Int
    let title: String?
    let overview: String?
    let vote_average: Double?
    let backdrop_path: String?
    let poster_path: String?
    let release_date: String?
}
