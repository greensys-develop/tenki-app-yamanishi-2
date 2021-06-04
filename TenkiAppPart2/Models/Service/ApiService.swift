//
//  APi.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/05/26.
//

import Moya
import RxSwift

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
    private let disposeBag = DisposeBag()
    
    func send<T>(_ request: T, completion: @escaping (Result<T.Response, MoyaError>) -> Void) where T : APITargetType {
        let provider = MoyaProvider<T>()
        provider.rx.request(request)
            .map { (response) -> T.Response? in
                return try? JSONDecoder().decode(T.Response.self, from: response.data)
            }.subscribe(onSuccess: {(response) in
                guard let unwrappedResponse = response else {
                    completion(.failure(.jsonMapping(response as! Response)))
                    return
                }
                completion(.success(unwrappedResponse))
            }, onError: {(error) in
                completion(.failure(error as! MoyaError))
            })
    }
}
