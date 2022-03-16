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
    
    let cityNameLabel = UILabel()
    var locationNameLabel = UILabel()

    var favoriteIcon = UIImageView()

    
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
        
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        locationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteIcon.translatesAutoresizingMaskIntoConstraints = false
  
        cityNameLabel.numberOfLines = 1
        cityNameLabel.textAlignment = .left
        locationNameLabel.numberOfLines = 1
        locationNameLabel.textAlignment = .left

        cityNameLabel.font = Constants.Fonts.searchFont
        locationNameLabel.font = Constants.Fonts.searchFont

    }
    
    func configureCell(cityName: String? = nil, locationName: String? = nil, favoriteState: Bool? = nil) {
        
        if let cityName = cityName {
            self.cityNameLabel.text = "City: \(cityName) "
        } else {
            self.cityNameLabel.text = "City: No City Name"
        }
        
        if let locationName = locationName {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "location")?.withTintColor(Constants.Colors.blackColor)
            let fullString = NSMutableAttributedString(string: "Location Type: \(locationName) ")
            fullString.append(NSAttributedString(attachment: imageAttachment))
            self.locationNameLabel.attributedText = fullString
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

        contentView.addSubview(cityNameLabel)
        contentView.addSubview(locationNameLabel)
        contentView.addSubview(favoriteIcon)

        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 1),
            cityNameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 40),
            cityNameLabel.widthAnchor.constraint(equalToConstant: 300),
            locationNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: cityNameLabel.bottomAnchor, multiplier: 1),
            locationNameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),
            locationNameLabel.heightAnchor.constraint(equalToConstant: 40),
            locationNameLabel.widthAnchor.constraint(equalToConstant: 300),
            favoriteIcon.heightAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizeSmall),
            favoriteIcon.widthAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizeSmall),
            favoriteIcon.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 4),
            self.trailingAnchor.constraint(equalToSystemSpacingAfter: favoriteIcon.trailingAnchor, multiplier: 1),
            self.bottomAnchor.constraint(equalToSystemSpacingBelow: favoriteIcon.bottomAnchor, multiplier: 4),

        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
