//
//  GenreResponse.swift
//  moviedb-mandiri
//
//  Created by Calvin Saragih on 19/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import Foundation

struct GenreResponse: Codable {

    var genres: [Genre]?

    private enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        genres = try values.decodeIfPresent([Genre].self, forKey: .genres)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(genres, forKey: .genres)
    }

}
