//
//  Networking.swift
//  Movien
//
//  Created by Işıl Aktürk on 22.02.2021.
//

import Foundation


struct HTTPMethod {
    static let get = "GET"
    static let post = "POST"
    static let delete = "DELETE"
}

struct MovieBaseURL {
    static let movieBaseURL = "https://api.themoviedb.org/3/discover/movie?"
}

struct ApiKEY {
    static let apiKey = "1ea84ccd13fffd396021995fa6f88a25"
}

struct SortTypes {
    static let popularity = "popularity"
    static let revenue = "revenue"
    static let voteCount = "vote_count"
}

enum SortedBy: String {
    case ascending = "asc"
    case descending = "desc"
}

struct MoviesImagePath {
    static let moviesImagePath = "https://image.tmdb.org/t/p/w500"
}
