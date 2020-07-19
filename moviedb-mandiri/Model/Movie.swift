//
//  Movie.swift
//  moviedb-mandiri
//
//  Created by Calvin Saragih on 19/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import Foundation

struct Movie: Codable {

    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterPath: String?
    let id: Int
    let originalTitle: String?
    let title: String
    let voteAverage: Double?
    let overview: String?
    let releaseDate: String?

    private enum CodingKeys: String, CodingKey {
        case popularity = "popularity"
        case voteCount = "vote_count"
        case video = "video"
        case posterPath = "poster_path"
        case id = "id"
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case title = "title"
        case voteAverage = "vote_average"
        case overview = "overview"
        case releaseDate = "release_date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        popularity = try values.decode(Double.self, forKey: .popularity)
        voteCount = try values.decode(Int.self, forKey: .voteCount)
        video = try values.decode(Bool.self, forKey: .video)
        posterPath = try values.decode(String.self, forKey: .posterPath)
        id = try values.decode(Int.self, forKey: .id)
        originalTitle = try values.decode(String.self, forKey: .originalTitle)
        title = try values.decode(String.self, forKey: .title)
        voteAverage = try values.decode(Double.self, forKey: .voteAverage)
        overview = try values.decode(String.self, forKey: .overview)
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(voteCount, forKey: .voteCount)
        try container.encode(video, forKey: .video)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(id, forKey: .id)
        try container.encode(originalTitle, forKey: .originalTitle)
        try container.encode(title, forKey: .title)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(overview, forKey: .overview)
        try container.encode(releaseDate, forKey: .releaseDate)
    }

}
