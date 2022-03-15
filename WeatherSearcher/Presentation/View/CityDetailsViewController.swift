//
//  CityDetailsViewController.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/15/22.
//

import UIKit
import Resolver
import SwiftUI
import Bond

class CityDetailsViewController: UIViewController {
    
    @Injected
    private var viewModel: SearcherCitiesViewModelProtocol
    
    //Variables for view Manage
    var woeidToFill: Int?
    var favorite: Bool?
    var weatherDetail = ShowCityDetailsEntity.init()
    
    // First View
    let iconTempStackView = UIStackView()
    let dataStackView = UIStackView()
    let leftStackView = UIStackView()
    
    let conditionImageView = UIImageView()
    let tempLabel = UILabel()
    let minMaxTempLabel = UILabel()
    let humityLabel = UILabel()
    let windSpeedLabel = UILabel()
    
    let favoriteButton = UIButton()
    
    let contentView = UIView()
    
    // Tableview
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = Constants.Colors.backgroundGray
        table.register(DetailsCell.self, forCellReuseIdentifier: DetailsCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
        

    }
}

extension CityDetailsViewController {
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self

        viewModel.getCityDetails(woeid: woeidToFill ?? 0)
        
        viewModel.city.observeNext(with: {[weak self] cityDetails in
            guard let cityDetailed = cityDetails else { return }
            self?.title = cityDetailed.title
        }).dispose(in: bag)
        
        viewModel.cityToshow.observeNext(with: {[weak self] cityToshow in
            guard let cityDetails = cityToshow else { return }
            self?.weatherDetail = cityDetails
            
            self?.configureView(false, cityDetails.conditionName, cityDetails.temp, cityDetails.minTemp, cityDetails.maxTemp, cityDetails.humidity, cityDetails.windSpeed ?? 0)
            if let favoriteObj = cityToshow?.favorite {
                self?.favorite = favoriteObj
            } else {
                self?.favorite = false
            }
            self?.tableView.reloadData()
        }).dispose(in: bag)
    }
    
    func style() {
        self.view.backgroundColor = Constants.Colors.backgroundGray
        
        contentView.backgroundColor = Constants.Colors.mainColor
        contentView.translatesAutoresizingMaskIntoConstraints = false
        iconTempStackView.translatesAutoresizingMaskIntoConstraints = false
        dataStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        minMaxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        humityLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.addTarget(self, action: #selector(favoritePressed), for: .touchUpInside)
        
        iconTempStackView.axis = .vertical
        iconTempStackView.spacing = 8
        iconTempStackView.distribution = .fillEqually
        
        dataStackView.axis = .vertical
        dataStackView.spacing = 4
        dataStackView.distribution = .fillEqually
        dataStackView.alignment = .leading
        
        leftStackView.axis = .vertical
        iconTempStackView.spacing = 8
        iconTempStackView.distribution = .fillEqually
        
//        rightStackView.axis = .horizontal
//        rightStackView.spacing = 8
//        rightStackView.distribution = .fillEqually
//        rightStackView.alignment = .top
        
//        containerStackView.axis = .horizontal
//        containerStackView.spacing = 4
//        containerStackView.distribution = .fillEqually
        
        tempLabel.numberOfLines = 1
        tempLabel.textAlignment = .center
        tempLabel.font = Constants.Fonts.tempFont
        tempLabel.adjustsFontSizeToFitWidth = true
        tempLabel.textColor = Constants.Colors.whiteGray
        
        minMaxTempLabel.numberOfLines = 1
        minMaxTempLabel.textAlignment = .center
        minMaxTempLabel.font = Constants.Fonts.subtitle
        minMaxTempLabel.adjustsFontSizeToFitWidth = true
        minMaxTempLabel.textColor = Constants.Colors.whiteGray
        
        humityLabel.numberOfLines = 1
        humityLabel.textAlignment = .center
        humityLabel.font = Constants.Fonts.subtitle
        humityLabel.adjustsFontSizeToFitWidth = true
        humityLabel.textColor = Constants.Colors.whiteGray
        
        windSpeedLabel.numberOfLines = 1
        windSpeedLabel.textAlignment = .center
        windSpeedLabel.font = Constants.Fonts.subtitle
        windSpeedLabel.adjustsFontSizeToFitWidth = true
        windSpeedLabel.textColor = Constants.Colors.whiteGray
        
    }
    
    @objc func favoritePressed(_ sender: UIButton) {
        if let favoriteState = favorite {
            if favoriteState {
                let imageIcon = UIImage(systemName: "star.fill")?.withTintColor(Constants.Colors.whiteGray, renderingMode: .alwaysOriginal)
                favoriteButton.setImage(imageIcon, for: .normal)
                self.favorite = false
            } else {
                let imageIcon = UIImage(systemName: "star.fill")?.withTintColor(Constants.Colors.favoriteYellow, renderingMode: .alwaysOriginal)
                favoriteButton.setImage(imageIcon, for: .normal)
                self.favorite = true
            }
        } else {
            let imageIcon = UIImage(systemName: "star.fill")?.withTintColor(Constants.Colors.favoriteYellow, renderingMode: .alwaysOriginal)
            favoriteButton.setImage(imageIcon, for: .normal)
            self.favorite = true
        }
        
    }
    
    func configureView(_ favorite:Bool = false,_ icon: String?,_ temp: Double?,_ minTemp: Double?,_ maxTemp: Double?,_ humity: Int?,_ windSpeed: Double?) {
        if favorite {
            let imageIcon = UIImage(systemName: "star.fill")?.withTintColor(Constants.Colors.favoriteYellow, renderingMode: .alwaysOriginal)
            favoriteButton.setImage(imageIcon, for: .normal)
        } else {
            let imageIcon = UIImage(systemName: "star.fill")?.withTintColor(Constants.Colors.whiteGray, renderingMode: .alwaysOriginal)
            favoriteButton.setImage(imageIcon, for: .normal)
        }
        let imageIcon = UIImage(systemName: icon!)?.withTintColor(Constants.Colors.whiteGray, renderingMode: .alwaysOriginal)
        self.conditionImageView.image = imageIcon
        
        if let tempDouble = temp {
            let tempText = String(format: "%.1f", tempDouble)
            tempLabel.text = "Temp: " + tempText
        }
        if let minTempDouble = minTemp,let maxTempDouble = maxTemp {
            let minTempText = String(format: "%.2f", minTempDouble)
            let maxTempText = String(format: "%.2f", maxTempDouble)
            minMaxTempLabel.text = "Min.: \(minTempText) - Max.: \(maxTempText)"
        }
        if let humityInt = humity {
            humityLabel.text = "Humity: \(humityInt)"
        }
        if let windSpeedDouble = windSpeed {
            let windSpeedText = String(format: "%.2f", windSpeedDouble)
            windSpeedLabel.text = "Wind Speed: " + windSpeedText
        }
        
    }
   
    
    func layout() {
        iconTempStackView.addArrangedSubview(conditionImageView)
        iconTempStackView.addArrangedSubview(tempLabel)
        dataStackView.addArrangedSubview(minMaxTempLabel)
        dataStackView.addArrangedSubview(humityLabel)
        dataStackView.addArrangedSubview(windSpeedLabel)
        leftStackView.addArrangedSubview(iconTempStackView)
        leftStackView.addArrangedSubview(dataStackView)
       
        self.contentView.addSubview(leftStackView)
        self.contentView.addSubview(favoriteButton)
        
        self.view.addSubview(contentView)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            leftStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            leftStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.contentView.leadingAnchor, multiplier: 1),
            self.contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: favoriteButton.trailingAnchor, multiplier: 1),
            self.favoriteButton.bottomAnchor.constraint(equalToSystemSpacingBelow: self.contentView.bottomAnchor, multiplier: 4),
            leftStackView.trailingAnchor.constraint(equalToSystemSpacingAfter: self.favoriteButton.leadingAnchor, multiplier: 1),
            self.contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: leftStackView.bottomAnchor, multiplier: 0),
            conditionImageView.heightAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizelarge),
            conditionImageView.widthAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizelarge),
            favoriteButton.heightAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizeSmall),
            favoriteButton.widthAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizeSmall),
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: contentView.trailingAnchor, multiplier: 0),
            contentView.heightAnchor.constraint(equalToConstant: view.frame.size.height * 0.3),
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.bottomAnchor, multiplier: 0),
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 0),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 1),
        ])
    }
    
}

extension CityDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weatherDetail.consolidatedWeather?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsCell.identifier) as? DetailsCell else { return UITableViewCell() }
        cell.configureCell(date: weatherDetail.consolidatedWeather?[indexPath.row].applicableDate, minTemp: weatherDetail.consolidatedWeather?[indexPath.row].minTemp, maxTemp: weatherDetail.consolidatedWeather?[indexPath.row].maxTemp, icon: weatherDetail.consolidatedWeather?[indexPath.row].conditionName)
        
        return cell
    }
    
}
