//
//  ViewController.swift
//  Skillbox-M19
//
//  Created by Максим Морозов on 23.12.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UISearchBarDelegate {

    let searchCellID = "searchCell"

    var presenter: FilmViewPresenterProtocol?

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Введите запрос"
        searchBar.sizeToFit()
        searchBar.delegate = self
        return searchBar
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: searchCellID)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
    }

    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.left.equalTo(view.snp.leftMargin)
            make.top.equalTo(view.snp.topMargin)
            make.right.equalTo(view.snp.rightMargin)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        presenter?.getFilmsByKeyword(searchBar.text ?? "")
    }
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.films?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: searchCellID, for: indexPath) as? SearchTableViewCell
        if let film = presenter?.films?[indexPath.row] {
            cell?.configure(film)
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Результаты по запросу: \(searchBar.text ?? "")"
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filmID = presenter?.films?[indexPath.row].filmId ?? 0
        Networking().loadDetailFilm(filmId: filmID) { result in
            DispatchQueue.main.async {
                let detailVC = ModuleBuilder.createDetailViewModule(film: result)
                self.navigationController?.pushViewController(detailVC, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}

extension ViewController: FilmViewProtocol {
    func getFilms() {
        tableView.reloadData()
    }
}
