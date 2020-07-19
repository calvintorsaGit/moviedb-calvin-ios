//
//  Video.swift
//  moviedb-mandiri
//
//  Created by Calvin Saragih on 19/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import Foundation

struct Video: Codable {

    let id: String
    let key: String
  

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case iso6391 = "iso_639_1"
        case iso31661 = "iso_3166_1"
        case key = "key"
        case name = "name"
        case site = "site"
        case size = "size"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        key = try values.decode(String.self, forKey: .key)
  
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(key, forKey: .key)
 
    }

}
