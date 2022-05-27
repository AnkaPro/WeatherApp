
import Foundation
import UIKit

extension CurrentGeoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.viewModel.hourlyOptions.value.main?.count ?? 0
    
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId, for: indexPath) as? CurrentGeoCollectionViewCell else { return UICollectionViewCell() }
    
    let configurator = CollectionCellConfigure(temperature: nil, date: nil, main: nil)
    
    if let dates = self.viewModel.hourlyOptions.value.date {
        configurator.date = dates[indexPath.row]
    }
    if let temperatures = self.viewModel.hourlyOptions.value.temperature {
        configurator.temperature = temperatures[indexPath.row]
    }
    if let weatherTexts = self.viewModel.hourlyOptions.value.main {
        configurator.main = weatherTexts[indexPath.row]
    }
    cell.viewModel.configure(config: configurator)
    
    return cell
}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let side = (collectionView.frame.size.width)/3
        
        return CGSize(width: side, height: side)
    }

}
