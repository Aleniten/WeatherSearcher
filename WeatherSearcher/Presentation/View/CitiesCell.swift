//
//  CitiesCell.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation
import UIKit

class CitiesCell: UITableViewCell {
    
    static let identifier = "CitiesCell"
    
    let titleNameLabel = UILabel()
    var cityNameLabel = UILabel()
    let locationTypeLabel = UILabel()
    var cityLocationLabel = UILabel()
    var favoriteIcon = UIImageView()
    
    let titleStackView = UIStackView()
    let locationStackView = UIStackView()
    let containerStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styles()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func styles() {
        self.backgroundColor = Constants.Colors.backgroundGray
        contentView.backgroundColor = .clear
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        locationStackView.translatesAutoresizingMaskIntoConstraints = false
        titleNameLabel.translatesAutoresizingMaskIntoConstraints = false
        locationTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteIcon.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.axis = .horizontal
        containerStackView.spacing = 0
        titleStackView.axis = .horizontal
        titleStackView.spacing = 0
        locationStackView.axis = .horizontal
        locationStackView.spacing = 0
        
        titleNameLabel.numberOfLines = 1
        titleNameLabel.textAlignment = .left
        cityNameLabel.numberOfLines = 1
        cityNameLabel.textAlignment = .center
        locationTypeLabel.numberOfLines = 1
        locationTypeLabel.textAlignment = .left
        cityLocationLabel.numberOfLines = 1
        cityLocationLabel.textAlignment = .center
        
        titleNameLabel.font = Constants.Fonts.title
        cityNameLabel.font = Constants.Fonts.subtitle
        locationTypeLabel.font = Constants.Fonts.title
        cityLocationLabel.font = Constants.Fonts.subtitle
    }
    
    func configureCell(cityName: String? = nil, cityLocation: String? = nil, favoriteState: Bool? = nil) {
        self.titleNameLabel.text = "City:"
        self.locationTypeLabel.text = "Location Type:"
        if let cityName = cityName {
            self.cityNameLabel.text = cityName
        } else {
            self.cityNameLabel.text = ""
        }
        if let locationType = cityLocation {
            self.cityLocationLabel.text = locationType
        } else {
            self.cityLocationLabel.text = ""
        }
        let image = UIImage(systemName: "star.fill")
        if let favorite = favoriteState, favorite == true {
            image?.withTintColor(Constants.Colors.favoriteYellow)
        } else {
            image?.withTintColor(Constants.Colors.whiteGray)
        }
        
        favoriteIcon.image = image
    }
    
    func layout() {
        titleStackView.addArrangedSubview(titleNameLabel)
        titleStackView.addArrangedSubview(cityNameLabel)
        locationStackView.addArrangedSubview(locationTypeLabel)
        locationStackView.addArrangedSubview(cityLocationLabel)
        containerStackView.addArrangedSubview(titleStackView)
        containerStackView.addArrangedSubview(locationStackView)
        containerStackView.addArrangedSubview(favoriteIcon)
        contentView.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            containerStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: containerStackView.trailingAnchor, multiplier: 1),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: containerStackView.bottomAnchor, multiplier: 1),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 21),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 21),
            titleNameLabel.heightAnchor.constraint(equalToConstant: 21),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 21),
            locationTypeLabel.heightAnchor.constraint(equalToConstant: 21),
            cityLocationLabel.heightAnchor.constraint(equalToConstant: 21),
            titleStackView.widthAnchor.constraint(equalToConstant: 200),
            locationStackView.widthAnchor.constraint(equalToConstant: 200),
//            titleNameLabel.widthAnchor.constraint(equalToConstant: 40),
//            cityNameLabel.widthAnchor.constraint(equalToConstant: 40),
//            locationTypeLabel.widthAnchor.constraint(equalToConstant: 40),
//            cityLocationLabel.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
