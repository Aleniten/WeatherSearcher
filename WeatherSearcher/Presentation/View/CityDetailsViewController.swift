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
    let containerStackView = UIStackView()
    
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
            
            
            self?.configureView(cityDetails.favorite, cityDetails.conditionName, cityDetails.temp, cityDetails.minTemp, cityDetails.maxTemp, cityDetails.humidity, cityDetails.windSpeed ?? 0)
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
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.addTarget(self, action: #selector(favoritePressed), for: .touchUpInside)
        
        iconTempStackView.axis = .vertical
        iconTempStackView.spacing = 2
        iconTempStackView.distribution = .fill
        
        dataStackView.axis = .vertical
        dataStackView.spacing = 1
        dataStackView.distribution = .fillProportionally
        dataStackView.alignment = .center
        
        leftStackView.axis = .vertical
        leftStackView.spacing = 2
        leftStackView.distribution = .fillEqually
        
        containerStackView.axis = .horizontal
        containerStackView.spacing = 0
        containerStackView.distribution = .fillProportionally
        
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
                self.deleteCitiesFromUserDefaults()
                let imageIcon = UIImage(systemName: "star.fill")?.withTintColor(Constants.Colors.whiteGray, renderingMode: .alwaysOriginal)
                favoriteButton.setImage(imageIcon, for: .normal)
                self.favorite = false
            } else {
                self.saveCitiesFromUserDefaults()
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
    func saveCitiesFromUserDefaults() {
        let cityToSave = CityEntity.init()
        
        cityToSave.lattLong = weatherDetail.lattLong
        cityToSave.locationType = weatherDetail.locationType
        cityToSave.title = weatherDetail.title
        cityToSave.woeid = weatherDetail.woeid
        cityToSave.favorite = true
        viewModel.saveCities(city: cityToSave)
    }
    func deleteCitiesFromUserDefaults() {
        let cityToDelete = CityEntity.init()
        
        cityToDelete.lattLong = weatherDetail.lattLong
        cityToDelete.locationType = weatherDetail.locationType
        cityToDelete.title = weatherDetail.title
        cityToDelete.woeid = weatherDetail.woeid
        cityToDelete.favorite = true
        
        viewModel.saveCities(city: cityToDelete)
    }
    func configureView(_ favorite:Bool? = false,_ icon: String?,_ temp: Double?,_ minTemp: Double?,_ maxTemp: Double?,_ humity: Int?,_ windSpeed: Double?) {
        
        if let isFavorite = favorite {
            if isFavorite {
                let imageIcon = UIImage(systemName: "star.fill")?.withTintColor(Constants.Colors.favoriteYellow, renderingMode: .alwaysOriginal)
                favoriteButton.setImage(imageIcon, for: .normal)
            } else {
                let imageIcon = UIImage(systemName: "star.fill")?.withTintColor(Constants.Colors.whiteGray, renderingMode: .alwaysOriginal)
                favoriteButton.setImage(imageIcon, for: .normal)
            }
            
        } else {
            let imageIcon = UIImage(systemName: "star.fill")?.withTintColor(Constants.Colors.whiteGray, renderingMode: .alwaysOriginal)
            favoriteButton.setImage(imageIcon, for: .normal)
        }
        if let imageIcon = icon {
            self.conditionImageView.image = UIImage(named: imageIcon)
        }
       
        
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

        dataStackView.addArrangedSubview(tempLabel)
        dataStackView.addArrangedSubview(minMaxTempLabel)
        dataStackView.addArrangedSubview(humityLabel)
        dataStackView.addArrangedSubview(windSpeedLabel)
        
        leftStackView.addArrangedSubview(iconTempStackView)
        leftStackView.addArrangedSubview(dataStackView)
       
        containerStackView.addArrangedSubview(leftStackView)
        containerStackView.addArrangedSubview(favoriteButton)

        self.contentView.addSubview(containerStackView)
        self.view.addSubview(contentView)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.contentView.leadingAnchor, multiplier: 1),
            self.contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: containerStackView.trailingAnchor, multiplier: 1),
            self.containerStackView.bottomAnchor.constraint(equalToSystemSpacingBelow: self.contentView.bottomAnchor, multiplier: 0),
            leftStackView.trailingAnchor.constraint(equalToSystemSpacingAfter: self.favoriteButton.leadingAnchor, multiplier: 1),
            self.contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: leftStackView.bottomAnchor, multiplier: 0),
            conditionImageView.heightAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizeSmall),
            conditionImageView.widthAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizeSmall),
            favoriteButton.heightAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizeSmall),
            favoriteButton.widthAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizeSmall),
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: contentView.trailingAnchor, multiplier: 0),
            contentView.heightAnchor.constraint(equalToConstant: view.frame.size.height * 0.4),
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
