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
    func sendRx<T: APITargetType>(_ request: T) -> Single<T.Response>
}

class WeatherAPIService: WeatherAPI {
    static let shared = WeatherAPIService()
    private let provider = MoyaProvider<MultiTarget>()
    
    func sendRx<T>(_ request: T) -> Single<T.Response> where T : APITargetType {
        
        Single<T.Response>.create { observer in
                    self.makeRequest(request)
                        .subscribe(onSuccess: { response in
                            observer(.success(response))
                        }, onError: { error in
                            //プロジェクト全体で共通して行いたいエラーハンドリング等
                            observer(.error(error))
                        })
                }
    }
    
    private func makeRequest<T: APITargetType>(_ request: T) -> Single<T.Response> {
        provider.rx
            .request(MultiTarget(request))
            .map(T.Response.self, failsOnEmptyData: false)
    }
    
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
