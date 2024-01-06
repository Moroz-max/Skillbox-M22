//
//  ModuleBuilder.swift
//  Skillbox-M19
//
//  Created by Максим Морозов on 06.01.2024.
//

import UIKit

protocol Builder {
    static func createMainViewModule() -> UIViewController
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
}
