//
//  CategoryViewModel.swift
//  moviedb-mandiri
//
//  Created by Calvin Saragih on 19/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import Foundation

class GenreViewModel:BaseViewModel {
    
    
    var genre = [Genre](){
        didSet{
            self.reloadData?()
        }
    }
    public var error : ((ErrorReporter)->Void)?
    private let apiHelper = ApiHelper()
    var reloadData:(()->())?
    
    func getGenre()  {
        self.apiHelper.requestData(url: ApiService.getAllGenre(), method: .get, parameters: nil, completion: {
            result in
            
            switch result {
            case .success(let json) :
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(GenreResponse.self, from: json)
                    if(response.genres != nil || response.genres?.count ?? 0 > 0 ){
                        self.genre = response.genres!
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let failure) :
                switch failure {
                case .connectionError:
                    self.error?(.internetError("Check your Internet connection."))
                case .authorizationError(let errorJson):
                    let errorMessage = Helper.getValueJson(json: errorJson, key: "message")
                    self.error?(.internetError(errorMessage))
                default:
                    self.error?(.serverMessage("Unknown Error"))
                }
                
            }
        })
    }
    
    
}
