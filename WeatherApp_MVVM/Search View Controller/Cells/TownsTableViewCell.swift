
import UIKit

class TownsTableViewCell: UITableViewCell {

    let townLabel = UILabel()
    let viewModel = TownsTableViewCellViewModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(townLabel)
        townLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let cellGuide = self.contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            townLabel.topAnchor.constraint(equalTo: cellGuide.topAnchor),
            townLabel.bottomAnchor.constraint(equalTo: cellGuide.bottomAnchor),
            townLabel.leadingAnchor.constraint(equalTo: cellGuide.leadingAnchor),
            townLabel.trailingAnchor.constraint(equalTo: cellGuide.trailingAnchor),
        ])
    }
    
    func bind() {
        viewModel.townLabelText.bind { text in
            self.townLabel.text = text
        }
    }

}
