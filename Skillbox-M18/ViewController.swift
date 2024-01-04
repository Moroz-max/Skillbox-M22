//
//  ViewController.swift
//  Skillbox-M18
//
//  Created by Максим Морозов on 22.12.2023.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {

    private lazy var searchTextField: UITextField = {
        let texfield = UITextField()
        texfield.placeholder = "Введите запрос"
        texfield.borderStyle = .roundedRect
        return texfield
    }()
    
    private lazy var urlSeccionButton: UIButton = {
        let button = UIButton()
        button.setTitle("URLSession", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.tag = 0
        button.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var alamofireButton: UIButton = {
        let button = UIButton()
        button.setTitle("Alamofire", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.tag = 1
        button.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var resultTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.cornerRadius = 8
        textView.text = "Результат"
        //textView.backgroundColor = .gray
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tap)
        
        setupViews()
        setupConstraints()
        
    }
    
    private func setupViews() {
        view.addSubview(searchTextField)
        view.addSubview(urlSeccionButton)
        view.addSubview(alamofireButton)
        view.addSubview(resultTextView)
    }
    
    private func setupConstraints() {
        searchTextField.snp.makeConstraints { make in
            make.left.equalTo(view.snp.leftMargin).offset(20)
            make.right.equalTo(view.snp.rightMargin).offset(-20)
            make.top.equalTo(view.snp.topMargin).offset(20)
        }
        urlSeccionButton.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.left.equalTo(view.snp.leftMargin).offset(20)
        }
        alamofireButton.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.right.equalTo(view.snp.rightMargin).offset(-20)
        }
        resultTextView.snp.makeConstraints { make in
            make.top.equalTo(urlSeccionButton.snp.bottom).offset(20)
            make.left.equalTo(view.snp.leftMargin).offset(20)
            make.right.equalTo(view.snp.rightMargin).offset(-20)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-20)
        }
        
    }

    @objc private func action(sender: UIButton) {
        view.endEditing(true)
        if sender.tag == 0 {
            Service().loadWithURLSession(requestText: self.searchTextField.text ?? "") { result in
                DispatchQueue.main.async {
                    self.resultTextView.text = result
                }
            }
        } else {
            Service().loadWithAlamofire(requestText: self.searchTextField.text ?? "") { result in
                DispatchQueue.main.async {
                    self.resultTextView.text = result
                }
            }
        }
        
    }
    
    @objc private func viewTapped() {
        view.endEditing(true)
    }
    
    
}

