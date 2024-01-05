//
//  ViewController.swift
//  Skillbox-M19
//
//  Created by Максим Морозов on 23.12.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let searchCellID = "searchCell"

    var isSearch = true
    var filmsArray = [Films]()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите запрос"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Поиск", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(searchButtonPresed), for: .touchUpInside)
        return button
    }()
    
    private lazy var popularFilmsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Популярные фильмы", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(popularFilmsPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: searchCellID)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupViews() {
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(popularFilmsButton)
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        searchTextField.snp.makeConstraints { make in
            make.left.equalTo(view.snp.leftMargin).offset(20)
            make.top.equalTo(view.snp.topMargin).offset(20)
            make.right.equalTo(view.snp.rightMargin).offset(-20)
        }
        searchButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.centerX.equalTo(searchTextField.snp.centerX)
        }
        popularFilmsButton.snp.makeConstraints { make in
            make.width.equalTo(220)
            make.height.equalTo(40)
            make.centerX.equalTo(searchButton.snp.centerX)
            make.top.equalTo(searchButton.snp.bottom).offset(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(popularFilmsButton.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    private func search(keyword: String) {
        Service().loadFilmsByKeyword(requestText: keyword) { result in
            self.filmsArray = result
            self.isSearch = true
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func topFilms() {
        Service().loadPopularFilms { result in
            self.filmsArray = result
            self.isSearch = false
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func searchButtonPresed() {
        search(keyword: searchTextField.text ?? "")
    }
    
    @objc func popularFilmsPressed() {
        topFilms()
    }

}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: searchCellID, for: indexPath) as? SearchTableViewCell
        cell?.configure(filmsArray[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearch {
            return "Результаты по запросу: \(searchTextField.text ?? "")"
        } else {
            return "Популярные фильмы"
        }
        
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        nextViewController.title = "О фильме"
        nextViewController.loadFilmData(id: filmsArray[indexPath.row].filmId)
        self.present(nextViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
