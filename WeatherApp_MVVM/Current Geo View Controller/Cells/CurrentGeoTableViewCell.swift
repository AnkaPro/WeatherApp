import UIKit
import Foundation

class CurrentGeoTableViewCell: UITableViewCell {

    let dateLabel = UILabel()
    let degreeLabel = UILabel()
    let weatherLabel = UILabel()
    let celsiusIcon = UIImageView()
    var weatherIcon = UIImageView()
    let dateFormatter = DateFormatter()
    lazy var animatableWeatherIconConstraints = {
        return (square: self.weatherIcon.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/10),
                rectangle: self.weatherIcon.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/7))
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(dateText: Int, degreeText: Int, weatherText: String) {
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEE, MMMM d"
        let dateInterval = Date(timeIntervalSince1970: TimeInterval(dateText))
        let date = dateFormatter.string(from: dateInterval)
        
        self.dateLabel.text = date
        self.degreeLabel.text = String(degreeText)
        self.weatherLabel.text = weatherText
        if weatherText == "Clear" {
        self.weatherIcon.image = UIImage(named: "Clear")
            self.animatableWeatherIconConstraints.square.isActive = true
        } else if weatherText == "Snow" {
            self.weatherIcon.image = UIImage(named: "Snow")
            self.animatableWeatherIconConstraints.square.isActive = true
        } else if weatherText == "Rain" {
            self.weatherIcon.image = UIImage(named: "Rain")
            self.animatableWeatherIconConstraints.rectangle.isActive = true
        } else if weatherText == "Clouds" {
            self.weatherIcon.image = UIImage(named: "Clouds")
            self.animatableWeatherIconConstraints.rectangle.isActive = true
        }
    }
    
    func setupUI() {
        
        self.dateLabel.numberOfLines = 3
        self.dateLabel.font = UIFont(name: "Inter-ExtraLight", size: 18)
        self.dateLabel.textAlignment = .left
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(dateLabel)
        
        self.degreeLabel.numberOfLines = 3
        self.degreeLabel.font = UIFont(name: "Inter-ExtraLight", size: 28)
        self.degreeLabel.textAlignment = .right
        self.degreeLabel.textColor = .black
        self.degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(degreeLabel)
        
        self.weatherLabel.numberOfLines = 3
        self.weatherLabel.font = UIFont(name: "Inter-ExtraLight", size: 18)
        self.weatherLabel.textAlignment = .right
        self.weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(weatherLabel)
        
        self.celsiusIcon.image = UIImage(named: "celsius black")
        self.celsiusIcon.sizeToFit()
        self.celsiusIcon.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(celsiusIcon)
        
        self.weatherIcon.sizeToFit()
        self.weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(weatherIcon)
        
        let cellGuide = self.contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: cellGuide.leadingAnchor),
            self.dateLabel.topAnchor.constraint(equalTo: cellGuide.topAnchor),
            self.dateLabel.bottomAnchor.constraint(equalTo: cellGuide.bottomAnchor),
            
            self.degreeLabel.trailingAnchor.constraint(equalTo: cellGuide.trailingAnchor, constant: -20),
            self.degreeLabel.topAnchor.constraint(equalTo: cellGuide.topAnchor),
            self.degreeLabel.bottomAnchor.constraint(equalTo: cellGuide.bottomAnchor),
            
            self.weatherLabel.leadingAnchor.constraint(equalTo: self.weatherIcon.trailingAnchor, constant: 20),
            self.weatherLabel.topAnchor.constraint(equalTo: cellGuide.topAnchor),
            self.weatherLabel.bottomAnchor.constraint(equalTo: cellGuide.bottomAnchor),
            
            self.celsiusIcon.leadingAnchor.constraint(equalTo: self.degreeLabel.trailingAnchor, constant: 10),
            self.celsiusIcon.topAnchor.constraint(equalTo: self.degreeLabel.topAnchor),
            self.celsiusIcon.heightAnchor.constraint(equalToConstant: 20),
            self.celsiusIcon.widthAnchor.constraint(equalToConstant: 15),
            
            self.weatherIcon.centerYAnchor.constraint(equalTo: cellGuide.centerYAnchor),
            self.weatherIcon.centerXAnchor.constraint(equalTo: cellGuide.centerXAnchor),
            self.weatherIcon.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2)
        ])
    }

}
