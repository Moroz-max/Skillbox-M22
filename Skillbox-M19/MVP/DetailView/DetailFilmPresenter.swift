//
//  DetailFilmPresenter.swift
//  Skillbox-M19
//
//  Created by Максим Морозов on 06.01.2024.
//

import Foundation

protocol DetailFilmViewProtocol: AnyObject {
    func getFilmDetail(film: DetailFilms?)
}

protocol DetailFilmViewPresenterProtocol: AnyObject {
    init(view: DetailFilmViewProtocol, networkService: NetworkingProtocol, film: DetailFilms)
    func setFilm()
}

class DetailFilmPresenter: DetailFilmViewPresenterProtocol {
    
    weak var view: DetailFilmViewProtocol?
    let networkService: NetworkingProtocol
    var film: DetailFilms?

    required init(view: DetailFilmViewProtocol, networkService: NetworkingProtocol, film: DetailFilms) {
        self.view = view
        self.networkService = networkService
        self.film = film
    }
    
    public func setFilm() {
        self.view?.getFilmDetail(film: film)
    }
}
