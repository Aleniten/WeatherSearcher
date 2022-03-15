//
//  DetailsCell.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/15/22.
//

import Foundation
import UIKit

class DetailsCell: UITableViewCell {
    
    static let identifier = "DetailsCell"
    
    let dateLabel = UILabel()
    var minMaxLabel = UILabel()
    var weatherIcon = UIImageView()

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
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        minMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.axis = .horizontal
        containerStackView.spacing = 10
        containerStackView.distribution = .fillEqually
  
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .left
        minMaxLabel.numberOfLines = 1
        minMaxLabel.textAlignment = .left

        dateLabel.font = Constants.Fonts.title
        minMaxLabel.font = Constants.Fonts.subtitle
        dateLabel.textColor = Constants.Colors.blackColor
        minMaxLabel.textColor = Constants.Colors.blackColor
     
        dateLabel.adjustsFontSizeToFitWidth = true
        minMaxLabel.adjustsFontSizeToFitWidth = true

    }
    
    func configureCell(date: String? = nil, minTemp: Double?, maxTemp: Double?, icon: String?) {
        if let dateText = date {
            self.dateLabel.text = "Date: " + dateText
        }
        
        
        if let minTempDouble = minTemp,let maxTempDouble = maxTemp {
            let minTempText = String(format: "%.2f", minTempDouble)
            let maxTempText = String(format: "%.2f", maxTempDouble)
            self.minMaxLabel.text = "Min.: \(minTempText) - Max.: \(maxTempText)"
        }
        
        let imageIcon = UIImage(systemName: icon!)?.withTintColor(Constants.Colors.blackColor, renderingMode: .alwaysOriginal)
        self.weatherIcon.image = imageIcon
    }
    
    func layout() {
       

        

        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(dateLabel)
        containerStackView.addArrangedSubview(minMaxLabel)
        containerStackView.addArrangedSubview(weatherIcon)

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            containerStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: containerStackView.trailingAnchor, multiplier: 1),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: containerStackView.bottomAnchor, multiplier: 1),

            weatherIcon.heightAnchor.constraint(equalToConstant: 32),
            weatherIcon.widthAnchor.constraint(equalToConstant: 32),
            dateLabel.heightAnchor.constraint(equalToConstant: 32),
            minMaxLabel.heightAnchor.constraint(equalToConstant: 32),

        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
