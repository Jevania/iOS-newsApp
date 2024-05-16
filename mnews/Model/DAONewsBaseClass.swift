//
//  DAONewsBaseClass.swift
//  mnews
//
//  Created by jevania on 13/05/24.
//

//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class DAONewsBaseClass : Codable {

    let articles : [Article]?
    let status : String?
    let totalResults : Int?

    enum CodingKeys: String, CodingKey {
        case articles = "articles"
        case status = "status"
        case totalResults = "totalResults"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        articles = try values.decodeIfPresent([Article].self, forKey: .articles)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
    }

}
