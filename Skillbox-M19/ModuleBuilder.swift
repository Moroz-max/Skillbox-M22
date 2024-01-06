//
//  ModuleBuilder.swift
//  Skillbox-M19
//
//  Created by Максим Морозов on 06.01.2024.
//

import UIKit

protocol Builder {
    static func createMainViewModule() -> UIViewController
    static func createDetailViewModule(film: DetailFilms?) -> UIViewController
}

class ModuleBuilder: Builder {

    static func createMainViewModule() -> UIViewController {
        let view = ViewController()
        let netWorkService = Networking()
        let presenter = FilmPresenter(view: view, networkService: netWorkService)
        view.presenter = presenter
        view.view.backgroundColor = .systemBackground
        return view
    }

    static func createDetailViewModule(film: DetailFilms?) -> UIViewController {
        let view = DetailViewController()
        let netWorkService = Networking()
        let presenter = DetailFilmPresenter(view: view, networkService: netWorkService, film: film!)
        view.presenter = presenter
        view.view.backgroundColor = .systemBackground
        return view
    }
}
