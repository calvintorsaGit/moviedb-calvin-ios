//
//  ListMovieViewModel.swift
//  moviedb-mandiri
//
//  Created by Calvin Saragih on 19/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import Foundation

class ListViewModel: BaseViewModel {
    
    var movies = [Movie](){
        didSet{
            self.reloadData?()
        }
    }
    var loading = false
    public var error : ((ErrorReporter)->Void)?
    private let apiHelper = ApiHelper()
    var reloadData:(()->())?
    
    func getMovieByGenre(page:Int,genre_id:Int)  {
        self.loading = true
        self.apiHelper.requestData(url: ApiService.getMovieByGenre(page: page, genre_id: genre_id), method: .get, parameters: nil, completion: {
            result in
        
            switch result {
            
            case .success(let json) :
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(Response<Movie>.self, from: json)
                    if(page == 1){
                        self.movies = response.results
                    }else{
                        response.results.forEach{
                            (movie) in
                            self.movies.append(movie)
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
                self.loading = false
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
                self.loading = false
            }
        })
    }
}
