//
//  Review.swift
//  moviedb-mandiri
//
//  Created by Calvin Saragih on 19/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import Foundation

struct Review: Codable {

    let author: String
    let content: String
    let id: String
    let url: String

    private enum CodingKeys: String, CodingKey {
        case author = "author"
        case content = "content"
        case id = "id"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author = try values.decode(String.self, forKey: .author)
        content = try values.decode(String.self, forKey: .content)
        id = try values.decode(String.self, forKey: .id)
        url = try values.decode(String.self, forKey: .url)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(author, forKey: .author)
        try container.encode(content, forKey: .content)
        try container.encode(id, forKey: .id)
        try container.encode(url, forKey: .url)
    }

}
