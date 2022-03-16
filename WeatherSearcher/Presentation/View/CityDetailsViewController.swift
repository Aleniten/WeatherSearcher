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

class CityDetailsViewController: BaseViewController {
    
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
    let weatherStateLabel = UILabel()
    let minMaxTempLabel = UILabel()
    let humityLabel = UILabel()
    let windSpeedLabel = UILabel()
    let backgroundView = UIImageView()
    
    let favoriteButton = UIButton()
    
    let buttonContainer = UIView()
    let contentView = UIView()
    var backgroundImage = UIView()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showSpinner(self.view, self.spinner.isShowing)
    }
}

extension CityDetailsViewController {
    
    func setup() {
        // Setup and some Injected Observers
        tableView.dataSource = self
        tableView.delegate = self

        viewModel.getCityDetails(woeid: woeidToFill ?? 0)
        
        viewModel.cityToshow.observeNext(with: {[weak self] cityToshow in
            if let spinnerShowing = self?.spinner.isShowing, let superView = self?.view {
                self?.showSpinner(superView, spinnerShowing)
            }
            guard let cityDetails = cityToshow else {
                self?.viewModel.cityDetailsRequestEncounter.observeNext(with: {[weak self] requestDetails in
                    if let requested = requestDetails {
                        if requested {
                            self?.alertPresent(title: "Whoops!", "We Have encounter a problem with your Request.")
                        }
                    }
                })
                return }
            self?.weatherDetail = cityDetails
            self?.title = cityDetails.title
            self?.configureView(cityDetails.favorite, cityDetails.conditionName, cityDetails.temp, cityDetails.minTemp, cityDetails.maxTemp, cityDetails.humidity, cityDetails.windSpeed ?? 0, cityDetails.weatherStateName, isDaylight: cityDetails.isDayLight)
            if let favoriteObj = cityToshow?.favorite {
                self?.favorite = favoriteObj
            } else {
                self?.favorite = false
            }
            self?.tableView.reloadData()
            self?.removeSpinner(0.5)
        }).dispose(in: bag)
        
        
    }
    
    func style() {
        self.view.backgroundColor = Constants.Colors.backgroundGray
        
        contentView.backgroundColor = Constants.Colors.mainColor
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        iconTempStackView.translatesAutoresizingMaskIntoConstraints = false
        weatherStateLabel.translatesAutoresizingMaskIntoConstraints = false
        dataStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        minMaxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        humityLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.addTarget(self, action: #selector(favoritePressed), for: .touchUpInside)
        buttonContainer.backgroundColor = .clear
        
        iconTempStackView.axis = .vertical
        iconTempStackView.spacing = 2
        iconTempStackView.distribution = .fillProportionally
        iconTempStackView.alignment = .center
        
        dataStackView.axis = .vertical
        dataStackView.spacing = 2
        dataStackView.distribution = .fillEqually
        dataStackView.alignment = .center
        
        leftStackView.axis = .horizontal
        leftStackView.spacing = 2
        leftStackView.distribution = .fillProportionally
        leftStackView.alignment = .center
        
        containerStackView.axis = .vertical
        containerStackView.spacing = 0
        containerStackView.distribution = .fillProportionally
        containerStackView.alignment = .center
        
        tempLabel.numberOfLines = 1
        tempLabel.textAlignment = .center
        tempLabel.font = Constants.Fonts.tempFont
        tempLabel.adjustsFontSizeToFitWidth = true
        tempLabel.layer.shadowColor = Constants.Colors.blackColor.cgColor
        tempLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        tempLabel.layer.shadowOpacity = 1.0
        tempLabel.layer.shadowRadius = 0.0
        
        
        weatherStateLabel.numberOfLines = 1
        weatherStateLabel.textAlignment = .center
        weatherStateLabel.font = Constants.Fonts.weatherState
        weatherStateLabel.adjustsFontSizeToFitWidth = true
        weatherStateLabel.layer.shadowColor = Constants.Colors.blackColor.cgColor
        weatherStateLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        weatherStateLabel.layer.shadowOpacity = 1.0
        weatherStateLabel.layer.shadowRadius = 0.0
        
        
        minMaxTempLabel.numberOfLines = 1
        minMaxTempLabel.textAlignment = .center
        minMaxTempLabel.font = Constants.Fonts.subtitle
        minMaxTempLabel.adjustsFontSizeToFitWidth = true
        minMaxTempLabel.layer.shadowColor = Constants.Colors.blackColor.cgColor
        minMaxTempLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        minMaxTempLabel.layer.shadowOpacity = 1.0
        minMaxTempLabel.layer.shadowRadius = 0.0
       
        
        humityLabel.numberOfLines = 1
        humityLabel.textAlignment = .center
        humityLabel.font = Constants.Fonts.subtitle
        humityLabel.adjustsFontSizeToFitWidth = true
        humityLabel.layer.shadowColor = Constants.Colors.blackColor.cgColor
        humityLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        humityLabel.layer.shadowOpacity = 1.0
        humityLabel.layer.shadowRadius = 0.0
        
        
        windSpeedLabel.numberOfLines = 1
        windSpeedLabel.textAlignment = .center
        windSpeedLabel.font = Constants.Fonts.subtitle
        windSpeedLabel.adjustsFontSizeToFitWidth = true
        windSpeedLabel.layer.shadowColor = Constants.Colors.blackColor.cgColor
        windSpeedLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        windSpeedLabel.layer.shadowOpacity = 1.0
        windSpeedLabel.layer.shadowRadius = 0.0
        
        
        backgroundImage.backgroundColor = Constants.Colors.mainColor
        // background
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        let image = self.image(with: backgroundImage)
        backgroundView.image = image
        backgroundView.contentMode = .scaleAspectFill
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
        viewModel.savedFavoritesState.observeNext(with: {[weak self] saved in
            if let spinnerShowing = self?.spinner.isShowing, let superView = self?.view {
                self?.showSpinner(superView, spinnerShowing)
            }
            self?.removeSpinner(0.5)
            if let savedCity = saved {
                if savedCity {
                    self?.alertPresent(title: "Success!", "We Have Saved your City in your Favorites!")
                } else {
                    self?.alertPresent(title: "Sorry!", "We had a problem saving the City.")
                }
               
            }
        }).dispose(in: bag)
    }
    func deleteCitiesFromUserDefaults() {
        let cityToDelete = CityEntity.init()
        
        cityToDelete.lattLong = weatherDetail.lattLong
        cityToDelete.locationType = weatherDetail.locationType
        cityToDelete.title = weatherDetail.title
        cityToDelete.woeid = weatherDetail.woeid
        cityToDelete.favorite = true
        
        viewModel.deleteCities(city: cityToDelete)
        viewModel.deletedFavoriteState.observeNext(with: {[weak self] deleted in
            if let spinnerShowing = self?.spinner.isShowing, let superView = self?.view {
                self?.showSpinner(superView, spinnerShowing)
            }
            self?.removeSpinner(0.5)
            
            if let deletedCity = deleted {
                if deletedCity {
                    self?.alertPresent(title: "Success!", "We Have Delete the City from your Favorites List!")
                } else {
                    self?.alertPresent(title: "Soory!", "We had a problem deleting the City.")
                }
               
            }
        }).dispose(in: bag)
    }
    func configureView(_ favorite: Bool? = false,_ icon: String?,_ temp: Double?,_ minTemp: Double?,_ maxTemp: Double?,_ humity: Int?,_ windSpeed: Double?,_ weatherState: String?, isDaylight: Bool?) {
        var tempDaylight: Bool = true
        let colorText = UIColor.white
        if let isDaylightUnwrapped = isDaylight {
            
            if isDaylightUnwrapped {
                backgroundView.image = UIImage(named: "day-background")
            } else {
                backgroundView.image = UIImage(named: "night-background")
                tempDaylight = false
            }
        } else {
            backgroundView.image = UIImage(named: "day-background")
        }
        
        
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
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : tempDaylight ? UIColor.red : Constants.Colors.blueForWeather,
          NSAttributedString.Key.foregroundColor : colorText,
              NSAttributedString.Key.strokeWidth : -4.0,
            NSAttributedString.Key.font : Constants.Fonts.weatherState]
          as [NSAttributedString.Key : Any]
        if let weatherStateText = weatherState {
            let fullString = NSMutableAttributedString(string: weatherStateText, attributes: strokeTextAttributes)
            self.weatherStateLabel.attributedText = fullString
        }

        if let tempDouble = temp {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "thermometer")?.withTintColor(tempDaylight ? UIColor.red : Constants.Colors.blueForWeather)
            let tempText = String(format: "%.1f", tempDouble)
            let fullString = NSMutableAttributedString(string: "Temperature: \(tempText) ", attributes: strokeTextAttributes)
            fullString.append(NSAttributedString(attachment: imageAttachment))
            tempLabel.attributedText = fullString
        }
        if let minTempDouble = minTemp,let maxTempDouble = maxTemp {
            let minTempText = String(format: "%.2f", minTempDouble)
            let maxTempText = String(format: "%.2f", maxTempDouble)
            let fullString = NSMutableAttributedString(string: "Min.: \(minTempText) - Max.: \(maxTempText)", attributes: strokeTextAttributes)
            minMaxTempLabel.attributedText = fullString
        }
        if let humityInt = humity {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "drop")?.withTintColor(tempDaylight ? UIColor.red : Constants.Colors.blueForWeather)
            let fullString = NSMutableAttributedString(string: "Humity: \(humityInt) ", attributes: strokeTextAttributes)
            fullString.append(NSAttributedString(attachment: imageAttachment))
            humityLabel.attributedText = fullString
        }
        if let windSpeedDouble = windSpeed {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "wind")?.withTintColor(tempDaylight ? UIColor.red : Constants.Colors.blueForWeather)
            let windSpeedText = String(format: "%.2f", windSpeedDouble)
            let fullString = NSMutableAttributedString(string: "Wind Speed: \(windSpeedText) ", attributes: strokeTextAttributes)
            fullString.append(NSAttributedString(attachment: imageAttachment))
            windSpeedLabel.attributedText = fullString
        }
        
    }
   
    
    func layout() {
        buttonContainer.addSubview(favoriteButton)
        
        leftStackView.addArrangedSubview(weatherStateLabel)
        leftStackView.addArrangedSubview(buttonContainer)
        
        dataStackView.addArrangedSubview(tempLabel)
        dataStackView.addArrangedSubview(minMaxTempLabel)
        dataStackView.addArrangedSubview(humityLabel)
        dataStackView.addArrangedSubview(windSpeedLabel)
       
        iconTempStackView.addArrangedSubview(conditionImageView)
        
        containerStackView.addArrangedSubview(iconTempStackView)
        containerStackView.addArrangedSubview(leftStackView)
        containerStackView.addArrangedSubview(dataStackView)

        self.contentView.addSubview(backgroundView)
        self.contentView.addSubview(containerStackView)
        
        self.view.addSubview(contentView)
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            conditionImageView.heightAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizelarge),
            conditionImageView.widthAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizelarge),
            favoriteButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor),
            favoriteButton.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor),
            favoriteButton.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor),
            buttonContainer.heightAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizelarge),
            buttonContainer.widthAnchor.constraint(equalToConstant: Constants.LocalSpacing.buttonSizelarge),
            backgroundView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            containerStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.contentView.leadingAnchor, multiplier: 1),
            self.contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: containerStackView.trailingAnchor, multiplier: 1),
            self.containerStackView.bottomAnchor.constraint(equalToSystemSpacingBelow: self.contentView.bottomAnchor, multiplier: 0),
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
        cell.configureCell(date: weatherDetail.consolidatedWeather?[indexPath.row].dateToShow, minTemp: weatherDetail.consolidatedWeather?[indexPath.row].minTemp, maxTemp: weatherDetail.consolidatedWeather?[indexPath.row].maxTemp, icon: weatherDetail.consolidatedWeather?[indexPath.row].conditionName)
        
        return cell
    }
    
}
