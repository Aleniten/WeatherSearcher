//
//  DetailsCell.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/15/22.
//

import Foundation
import UIKit
// Cell for Details of city selected in CityDetailsViewController
class DetailsCell: UITableViewCell {
    
    static let identifier = "DetailsCell"
    
    var dateLabel = UILabel()
    var minMaxLabel = UILabel()
    var weatherIcon = UIImageView()
    var windSpeedLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styles()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func styles() {
        self.backgroundColor = Constants.Colors.mainColor
        contentView.backgroundColor = .clear
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        minMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        
  
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .center
        
        minMaxLabel.numberOfLines = 1
        minMaxLabel.textAlignment = .center
        
        windSpeedLabel.numberOfLines = 1
        windSpeedLabel.textAlignment = .center

        dateLabel.font = Constants.Fonts.tempFont
        minMaxLabel.font = Constants.Fonts.cellFont
        windSpeedLabel.font = Constants.Fonts.cellFont
        
        dateLabel.textColor = Constants.Colors.whiteGray
        minMaxLabel.textColor = Constants.Colors.whiteGray
        windSpeedLabel.textColor = Constants.Colors.whiteGray

    }
    
    func configureCell(date: String? = nil, minTemp: Double?, maxTemp: Double?, icon: String?, windSpeed: Double?) {
        if let dateText = date {
            self.dateLabel.text = dateText
        }
        
        
        if let minTempDouble = minTemp,let maxTempDouble = maxTemp {
            let minTempText = String(format: "%.2f", minTempDouble)
            let maxTempText = String(format: "%.2f", maxTempDouble)
            self.minMaxLabel.text = "Min.: \(minTempText) - Max.: \(maxTempText)"
        }
        
        if let imageIcon = icon {
            self.weatherIcon.image = UIImage(named: imageIcon)
        }
        
        if let windSpeedDouble = windSpeed {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "wind")?.withTintColor(Constants.Colors.whiteGray)
            let windSpeedText = String(format: "%.2f", windSpeedDouble)
            let fullString = NSMutableAttributedString(string: "Wind Speed: \(windSpeedText) ")
            fullString.append(NSAttributedString(attachment: imageAttachment))
            windSpeedLabel.attributedText = fullString
        }
        
    }
    
    func layout() {
       

        

        contentView.addSubview(dateLabel)
        contentView.addSubview(minMaxLabel)
        contentView.addSubview(weatherIcon)
        contentView.addSubview(windSpeedLabel)
        

        NSLayoutConstraint.activate([

        dateLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 1),
        dateLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),
        dateLabel.heightAnchor.constraint(equalToConstant: 40),
        dateLabel.widthAnchor.constraint(equalToConstant: 300),
        minMaxLabel.topAnchor.constraint(equalToSystemSpacingBelow: dateLabel.bottomAnchor, multiplier: 1),
        minMaxLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),
        minMaxLabel.heightAnchor.constraint(equalToConstant: 20),
        minMaxLabel.widthAnchor.constraint(equalToConstant: 300),
        windSpeedLabel.topAnchor.constraint(equalToSystemSpacingBelow: minMaxLabel.bottomAnchor, multiplier: 1),
        windSpeedLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),
        windSpeedLabel.heightAnchor.constraint(equalToConstant: 20),
        windSpeedLabel.widthAnchor.constraint(equalToConstant: 300),
        self.bottomAnchor.constraint(equalToSystemSpacingBelow: windSpeedLabel.bottomAnchor, multiplier: 1),
        weatherIcon.heightAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizeSmall),
        weatherIcon.widthAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizeSmall),
        weatherIcon.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 1),
        self.trailingAnchor.constraint(equalToSystemSpacingAfter: weatherIcon.trailingAnchor, multiplier: 1),

        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
