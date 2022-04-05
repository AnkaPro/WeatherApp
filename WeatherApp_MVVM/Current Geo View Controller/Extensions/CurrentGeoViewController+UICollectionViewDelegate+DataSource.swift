
import Foundation
import UIKit

extension CurrentGeoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let count = self.viewModel.hourlyOptions.value.main?.count else { return 0 }
    return count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId, for: indexPath) as? CurrentGeoCollectionViewCell else { fatalError() }
    guard let dates = self.viewModel.hourlyOptions.value.date else { return cell}
    let date = dates[indexPath.row]
    guard let temperatures = self.viewModel.hourlyOptions.value.temperature else { return cell }
    let temp = temperatures[indexPath.row]
    guard let weatherTexts = self.viewModel.hourlyOptions.value.main else { return cell }
    let main = weatherTexts[indexPath.row]
    
    cell.configure(degreeLabelText: temp, hourLabelText: date, main: main)
    
    return cell
}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let side = (collectionView.frame.size.width)/3
        
        return CGSize(width: side, height: side)
    }

}
