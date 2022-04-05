
import UIKit

class CurrentGeoCollectionViewCell: UICollectionViewCell {
    
    var degreeLabel = UILabel()
    var hourLabel = UILabel()
    var weatherImage = UIImageView()
    let celsiusIcon = UIImageView()
    let dateFormatter = DateFormatter()
    lazy var animatableWeatherIconConstraints = {
        return (square: self.weatherImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4),
                rectangle: self.weatherImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3))
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(weatherImage)
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        degreeLabel.font = UIFont(name: "Inter-ExtraLight", size: 25)
        degreeLabel.textColor = .black
        self.addSubview(degreeLabel)
        degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        hourLabel.font = UIFont(name: "Inter-ExtraLight", size: 20)
        self.addSubview(hourLabel)
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        celsiusIcon.image = UIImage(named: "celsius black")
        celsiusIcon.sizeToFit()
        self.addSubview(celsiusIcon)
        celsiusIcon.translatesAutoresizingMaskIntoConstraints = false
    
        
        NSLayoutConstraint.activate([
            weatherImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            weatherImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/4),
            
            hourLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            hourLabel.bottomAnchor.constraint(equalTo: weatherImage.topAnchor, constant: -10),
            
            degreeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            degreeLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 10),
            
            celsiusIcon.leadingAnchor.constraint(equalTo: degreeLabel.trailingAnchor, constant: 10),
            celsiusIcon.topAnchor.constraint(equalTo: degreeLabel.topAnchor),
            celsiusIcon.heightAnchor.constraint(equalToConstant: 20),
            celsiusIcon.widthAnchor.constraint(equalToConstant: 15),
        ])
    }
    
    func configure(degreeLabelText: Int, hourLabelText: Int, main: String) {
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "h a"
        let dateInterval = Date(timeIntervalSince1970: TimeInterval(hourLabelText))
        let date = dateFormatter.string(from: dateInterval)
        degreeLabel.text = String(degreeLabelText)
        hourLabel.text = date
        
        if main == "Clouds" {
            weatherImage.image = UIImage(named: main)
            animatableWeatherIconConstraints.rectangle.isActive = true
        } else if main == "Rain" {
            weatherImage.image = UIImage(named: main)
            animatableWeatherIconConstraints.rectangle.isActive = true
        } else if main == "Snow" {
            weatherImage.image = UIImage(named: main)
            animatableWeatherIconConstraints.square.isActive = true
        } else if main == "Clear" {
            weatherImage.image = UIImage(named: main)
            animatableWeatherIconConstraints.square.isActive = true
        }
    }

}

