//
//  APi.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/05/26.
//

import Moya

let appid = "5dfc577c1d7d94e9e23a00431582f1ac"

protocol APITargetType: TargetType {
    associatedtype Response: Codable
}

extension APITargetType { 
    var method: Moya.Method { return .get }
    var baseURL: URL { return URL(string: "https://api.openweathermap.org/data/2.5/")! }
    var headers: [String : String]? { return ["Content-Type": "application/json"] }
    var sampleData: Data { return Data() }
}

protocol WeatherAPI {
    func send<T: APITargetType>(_ request: T, completion: @escaping (Result<T.Response, Moya.MoyaError>) -> Void)
}

class WeatherAPIService: WeatherAPI {
    func send<T>(_ request: T, completion: @escaping (Result<T.Response, MoyaError>) -> Void) where T : APITargetType {
        let provider = MoyaProvider<T>()
        provider.request(request) { (result) in
            switch result {
            case let .success(response):
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(T.Response.self, from: response.data) {
                    completion(.success(model))
                    print(try! response.mapJSON())
                } else {
                    completion(.failure(.jsonMapping(response)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
