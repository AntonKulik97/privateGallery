

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
     static let shared = CustomCollectionViewCell()
    
    func setup(photoObject: PhotoObject?){
       
        let img = PhotoObjectManager.shared.loadSave(fileName: photoObject?.photo ?? "")
        imageView.image = img
    }
}
