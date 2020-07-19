//
//  ApiService.swift
//  Apple Repos
//
//  Created by Calvin Saragih on 15/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import Foundation

class ApiService  {
    
    static var API_KEY = "bae2be69b4466f2497a730a934311777"
    static var BASE_URL = "https://api.themoviedb.org/3"
    static var GENRE = "/genre/movie/list"
    static var DISCOVER = "/discover/movie/"
    static var REVIEW = "/movie/{movie_id}/reviews"
    static var BASE_POSTER_PATH = "https://image.tmdb.org/t/p/w185"
    static func getAllGenre() -> String{
        return "\(BASE_URL)\(GENRE)?api_key=\(API_KEY)"
    }
    
    static func getMovieByGenre(page:Int,genre_id:Int) -> String{
        return "\(BASE_URL)\(DISCOVER)?api_key=\(API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=true&page=\(page)&with_genres=\(genre_id)"
    }
    
    static func getReview(movie_id:Int ,page:Int) -> String{
        return "\(BASE_URL)/movie/\(movie_id)/reviews?api_key=\(API_KEY)&language=en-US&page=\(page)"
    }
   
    static func getYoutube(movie_id:Int) -> String{
           return "\(BASE_URL)/movie/\(movie_id)/videos?api_key=\(API_KEY)&language=en-US"
       }
    
   
    
}
