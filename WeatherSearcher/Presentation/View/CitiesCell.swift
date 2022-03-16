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

    var favoriteIcon = UIImageView()

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
        titleNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteIcon.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.axis = .horizontal
        containerStackView.spacing = 10
        containerStackView.distribution = .fillProportionally
        containerStackView.alignment = .center
  
        titleNameLabel.numberOfLines = 1
        titleNameLabel.textAlignment = .left
        cityNameLabel.numberOfLines = 1
        cityNameLabel.textAlignment = .left

        titleNameLabel.font = Constants.Fonts.title
        cityNameLabel.font = Constants.Fonts.subtitle
     
        titleNameLabel.adjustsFontSizeToFitWidth = true
        cityNameLabel.adjustsFontSizeToFitWidth = true

    }
    
    func configureCell(cityName: String? = nil, favoriteState: Bool? = nil) {
        self.titleNameLabel.text = "City:"
        
        if let cityName = cityName {
            self.cityNameLabel.text = cityName
        } else {
            self.cityNameLabel.text = ""
        }
        
        if favoriteState == true {
            favoriteIcon.isHidden = false
            let imageIcon = UIImage(systemName: "star.fill")?.withTintColor(Constants.Colors.favoriteYellow, renderingMode: .alwaysOriginal)
            favoriteIcon.image = imageIcon
        } else if favoriteState == false || favoriteState == nil {
            
            favoriteIcon.isHidden = true
        }
    }
    
    func layout() {

        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleNameLabel)
        containerStackView.addArrangedSubview(cityNameLabel)
        containerStackView.addArrangedSubview(favoriteIcon)

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            containerStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: containerStackView.trailingAnchor, multiplier: 1),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: containerStackView.bottomAnchor, multiplier: 1),

            favoriteIcon.heightAnchor.constraint(equalToConstant: 32),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 32),
            titleNameLabel.heightAnchor.constraint(equalToConstant: 32),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 32),

        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
