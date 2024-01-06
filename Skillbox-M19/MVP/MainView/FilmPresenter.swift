//
//  Presenter.swift
//  Skillbox-M19
//
//  Created by Максим Морозов on 05.01.2024.
//

import Foundation

protocol FilmViewProtocol: AnyObject {
    func getFilms()
}

protocol FilmViewPresenterProtocol: AnyObject {
    init(view: FilmViewProtocol, networkService: NetworkingProtocol)
    func getFilmsByKeyword(_ keyword: String)
    var films: [Films]? { get set}
}

class FilmPresenter: FilmViewPresenterProtocol {

    weak var view: FilmViewProtocol?
    let networkService: NetworkingProtocol
    var films: [Films]?

    required init(view: FilmViewProtocol, networkService: NetworkingProtocol) {
        self.view = view
        self.networkService = networkService
    }

    func getFilmsByKeyword(_ keyword: String) {
        Networking().getSearchResults(keyword: keyword) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let films):
                    self.films = films
                    self.view?.getFilms()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
