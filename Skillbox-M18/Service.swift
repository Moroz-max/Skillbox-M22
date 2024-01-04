//
//  Service.swift
//  Skillbox-M18
//
//  Created by Максим Морозов on 22.12.2023.
//
import Foundation
import UIKit
import Alamofire

struct Service {
    
    func loadWithURLSession(requestText: String, completion: @escaping (_ result: String) -> ())  {
        let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(requestText)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["X-API-KEY":"5322aeb4-16a0-4aea-8856-a46b71258e52"]
        request.httpBody = nil
        
        var resultString = String()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion("Ошибка")
            } else {
                if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    print(json)
                    if let string = String(data: data, encoding: String.Encoding.utf8) {
                        resultString = string
                        completion(resultString)
                    }
                } else {
                    resultString = "Что-то пошло не так"
                }
            }
        }
        task.resume()
    }
        
    
    func loadWithAlamofire(requestText: String, completion: @escaping (_ result: String) -> ()) {
        let headers: HTTPHeaders = [
                "X-API-KEY": "5322aeb4-16a0-4aea-8856-a46b71258e52"
            ]
        AF.request("https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(requestText)",headers: headers).response { response in
            if response.error == nil {
                debugPrint(response)
                if let data = response.data {
                    if let json = try? JSONSerialization.jsonObject(with: data) {
                        print(json)
                        if let string = String(data: data, encoding: String.Encoding.utf8) {
                            completion(string)
                        }
                    } else {
                        completion("Что-то пошло не так")
                    }
                } else {
                    completion("Что то пошло не так")
                }
                
            } else {
                completion("Ошибка")
            }
        }
    }
    
}
