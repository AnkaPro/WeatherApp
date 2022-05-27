
import UIKit

class CurrentGeoCollectionViewCell: UICollectionViewCell {
    
    let viewModel = CurrentGeoCollectionViewCellViewModel()
    var degreeLabel = UILabel()
    var hourLabel = UILabel()
    var weatherImage = UIImageView()
    let celsiusIcon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(weatherImage)
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.contentMode = .scaleAspectFit
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
    
    func bind() {
        viewModel.degreeLabelText.bind { text in
            self.degreeLabel.text = text
        }
        viewModel.hourLabelText.bind { text in
            self.hourLabel.text = text
        }
        viewModel.weatherImage.bind { image in
            self.weatherImage.image = image
        }
    }
}



