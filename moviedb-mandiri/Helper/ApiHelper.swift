//
//  ApiHelper.swift
//  Apple Repos
//
//  Created by Calvin Saragih on 15/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import Foundation

class ApiHelper {
    
    
    
    static let apiKey = "LINWfLCh3j_qZ4i1IHGOfmLf16beMGUeFYArrejSX34"
    
    typealias parameters = [String:Any]
    
    var task:URLSessionTask? = nil
    
    enum ApiResult {
        case success(Data)
        case failure(RequestError)
    }
    enum HTTPMethod: String {
        case get     = "GET"
        case post    = "POST"
        case put     = "PUT"
    }
    enum RequestError: Error {
        case unknownError
        case connectionError
        case authorizationError(Data)
        case serverError
    }
    
    
    func requestData(url:String,method:HTTPMethod,parameters:parameters?,completion: @escaping (ApiResult)->Void) {
        
        let header =  ["Authorization" : "Client-ID \(ApiHelper.apiKey)"]
        
        var urlRequest = URLRequest(url: URL(string:url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpMethod = method.rawValue
        if let parameters = parameters {
            let parameterData = parameters.reduce("") { (result, param) -> String in
                return result + "&\(param.key)=\(param.value as! String)"
            }.data(using: .utf8)
            urlRequest.httpBody = parameterData
        }
        self.task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error)
                completion(ApiResult.failure(.connectionError))
            }else if let data = data ,let responseCode = response as? HTTPURLResponse {
//                let responseJson = String(data: data, encoding: String.Encoding.utf8)  ?? ""
//                print("responseCode : \(responseCode.statusCode)")
//                print("responseJSON : \(responseJson)")
                switch responseCode.statusCode {
                case 200:
                    completion(ApiResult.success(data))
                case 400...499:
                    completion(ApiResult.failure(.authorizationError(data)))
                case 500...599:
                    completion(ApiResult.failure(.serverError))
                default:
                    completion(ApiResult.failure(.unknownError))
                    break
                    
                }
            }
        }   
        task?.resume()
        
    }
    
    func cancelTask(){
        task?.cancel()
    }
}
