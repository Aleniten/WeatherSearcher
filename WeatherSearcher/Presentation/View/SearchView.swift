//
//  SearchView.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation
import UIKit
import Bond

class SearchView: UIView {
    
    // search
    let searchStackView = UIStackView()
    let searchTextField = UITextField()
    let searchButton = UIButton()
    var newText: Observable<String?> = Observable(nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        stylesForLabels()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    func setup() {
        searchTextField.delegate = self
//        searchTextField.reactive.text.bind(to: newText)
//        searchTextField.reactive.
    }
    
    func stylesForLabels() {
        self.backgroundColor = Constants.Colors.whiteGray
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        searchStackView.spacing = 8
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.font = Constants.Fonts.searchFont
        searchTextField.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        searchTextField.placeholder = "Search"
        searchTextField.textAlignment = .left
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = Constants.Colors.whiteGray
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchPressed(_:)), for: .primaryActionTriggered)
        searchButton.tintColor = Constants.Colors.mainColor
    }
    
//    func configureView() {
//
//    }
    
    func layout() {
        searchStackView.addArrangedSubview(searchTextField)
        searchStackView.addArrangedSubview(searchButton)
        
        self.addSubview(searchStackView)
        NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalTo: self.topAnchor),
            searchStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 0),
            self.trailingAnchor.constraint(equalToSystemSpacingAfter: searchStackView.trailingAnchor, multiplier: 0),
            searchTextField.topAnchor.constraint(equalToSystemSpacingBelow: searchStackView.topAnchor, multiplier: 1),
            searchTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: searchStackView.leadingAnchor, multiplier: 1),
            searchButton.heightAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizeSmall),
            searchButton.widthAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizeSmall),
            searchStackView.trailingAnchor.constraint(equalToSystemSpacingAfter: searchButton.trailingAnchor, multiplier: 1),
        ])
    }
}

extension SearchView: UITextFieldDelegate {
    
    @objc func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            NotificationCenter.default.post(name: NSNotification.Name("searchedText"), object: nil, userInfo: ["text": city])
        }
        
        searchTextField.text = ""
    }
}
