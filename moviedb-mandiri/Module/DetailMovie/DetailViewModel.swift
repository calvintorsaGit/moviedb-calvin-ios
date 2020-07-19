//
//  DetailViewModel.swift
//  moviedb-mandiri
//
//  Created by Calvin Saragih on 19/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import Foundation

class DetailViewModel:BaseViewModel {
    
    //data review and closure to reload data
    var review = [Review](){
        didSet{
            self.reloadData?()
        }
    }
    var reloadData:(()->())?
    
    //data loading and closure
    var loading = false{
        didSet{
            self.stopLoading?(loading)
        }
    }
    var stopLoading:((_ loading:Bool)->())?
    
    // data youtube
    var youtubeVideo:((_ url:String)->())?
    
    public var error : ((ErrorReporter)->Void)?
    private let apiHelper = ApiHelper()
    
    
    func getReview(movie_id:Int,page:Int) {
        self.loading = true
        self.apiHelper.requestData(url: ApiService.getReview(movie_id: movie_id, page: page), method: .get, parameters: nil, completion: {
            result in
            
            switch result {
                
            case .success(let json) :
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(Response<Review>.self, from: json)
                    if(page == 1){
                        self.review = response.results
                    }else{
                        response.results.forEach{
                            (movie) in
                            self.review.append(movie)
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
    
    func getYoutube(movie_id:Int) {

        self.apiHelper.requestData(url: ApiService.getYoutube(movie_id: movie_id), method: .get, parameters: nil, completion: {
            result in
            
            switch result {
                
            case .success(let json) :
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(Response<Video>.self, from: json)
                    if(response.results.count > 0){
                        self.youtubeVideo!(response.results[0].key)
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
