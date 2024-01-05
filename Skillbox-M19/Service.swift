//
//  Service.swift
//  Skillbox-M19
//
//  Created by Максим Морозов on 23.12.2023.
//

import Foundation

struct Service {
    func loadFilmsByKeyword(requestText: String, completion: @escaping (_ result: [Films]) -> ()) {
        let link = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(requestText)"
        
        guard let url = URL(string: link) else { return }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["X-API-KEY":"5322aeb4-16a0-4aea-8856-a46b71258e52"]
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                error == nil
            else {
                return
            }
            if let data = data, let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])  {
                let jsonDict = jsonObject as? [String: Any]
                let arr = jsonDict?["films"] as? [[String: Any]]
                var model = [Films]()
                arr?.forEach { arrInfo in
                    let film = Films(filmId: arrInfo["filmId"] as? Int ?? 0, 
                                     nameRu: arrInfo["nameRu"] as? String ?? "Без названия" ,
                                     posterUrl: arrInfo["posterUrl"] as? String ?? "")
                    model.append(film)
                }
                completion(model)
            }
        }
        task.resume()
    }
    
    func loadPopularFilms(completion: @escaping (_ result: [Films]) -> ()) {
        let link = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS"
        
        guard let url = URL(string: link) else { return }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["X-API-KEY":"5322aeb4-16a0-4aea-8856-a46b71258e52"]
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                error == nil
            else {
                return
            }
            if let data = data, let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])  {
                let jsonDict = jsonObject as? [String: Any]
                let arr = jsonDict?["films"] as? [[String: Any]]
                var model = [Films]()
                arr?.forEach { arrInfo in
                    let film = Films(filmId: arrInfo["filmId"] as? Int ?? 0, 
                                     nameRu: arrInfo["nameRu"] as? String ?? "Без названия" ,
                                     posterUrl: arrInfo["posterUrl"] as? String ?? "")
                    model.append(film)
                }
                completion(model)
            }
        }
        task.resume()
    }
    
    func loadDetailFilm(filmId: Int, completion: @escaping (_ result: DetailFilms) -> ()) {
        let link = "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(filmId)"
        
        guard let url = URL(string: link) else { return }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["X-API-KEY":"5322aeb4-16a0-4aea-8856-a46b71258e52"]
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                error == nil
            else {
                return
            }
            if let data = data, let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])  {
                let jsonDict = jsonObject as? [String: Any]
                let model = DetailFilms(nameRu: jsonDict?["nameRu"] as? String ?? "Без названия",
                                        nameOriginal: jsonDict?["nameOriginal"] as? String ?? "",
                                        posterUrl: jsonDict?["posterUrl"] as? String ?? "",
                                        ratingKinopoisk: jsonDict?["ratingKinopoisk"] as? Double ?? 0.0,
                                        ratingImdb: jsonDict?["ratingImdb"] as? Double ?? 0.0,
                                        year: jsonDict?["year"] as? Int ?? 0,
                                        filmLength: jsonDict?["filmLength"] as? Int ?? 0,
                                        description: jsonDict?["description"] as? String ?? "")
                completion(model)
            }
        }
        task.resume()
    }
}
