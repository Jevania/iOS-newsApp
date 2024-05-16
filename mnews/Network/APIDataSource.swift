//
//  APIDataSource.swift
//  mnews
//
//  Created by jevania on 13/05/24.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias onFailed = (_ message: String?) -> ()

class APIDataSource {
    static func getNews(type: String, onSuccess: @escaping (_ result: DAONewsBaseClass) -> Void, onFailed: @escaping onFailed) {
            AF.request("\(APIConstant.NEWS_BASE_URL)\(type)apiKey=\(APIConstant.NEWS_API_KEY)", method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:]).responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    onFailed(error.errorDescription)
                case .success(let data):
                    print("Data: \(data)")
                    let jsonDecoder = JSONDecoder()
                    do {
                        let newsData = try jsonDecoder.decode(DAONewsBaseClass.self, from: response.data ?? Data())
                        onSuccess(newsData)
                    } catch {
                        onFailed("Error to decode")
                    }
                }
            }
        }
}
