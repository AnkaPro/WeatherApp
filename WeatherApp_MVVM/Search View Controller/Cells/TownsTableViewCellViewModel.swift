
import Foundation

class TownsTableViewCellViewModel {
    
    var townLabelText = Bindable<String?>(nil)
    
    func configure(with text: String) {
        townLabelText.value = text
    }
}
