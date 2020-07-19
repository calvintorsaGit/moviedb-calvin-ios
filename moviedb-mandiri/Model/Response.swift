//
//  Response.swift
//  moviedb-mandiri
//
//  Created by Calvin Saragih on 19/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import Foundation

struct Response<T>: Codable where T:Codable  {

    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: [T]

    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        results = try values.decode([T].self, forKey: .results)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(page, forKey: .page)
        try container.encode(totalResults, forKey: .totalResults)
        try container.encode(totalPages, forKey: .totalPages)
        try container.encode(results, forKey: .results)
    }

}
