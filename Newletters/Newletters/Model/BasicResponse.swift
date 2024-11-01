//
//  GeneralResponse.swift
//  News
//
//  Created by Jorge Alfredo Cruz Acuña on 29/10/24.
//

import Foundation

struct BasicResponse<T:Codable>:Codable {
    let status: String
    let copyright: String
    let numResults: Int
    let results: [T]

    enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case numResults = "num_results"
        case results
    }
}
