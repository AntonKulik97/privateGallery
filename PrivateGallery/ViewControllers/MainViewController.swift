
import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    let imagePicker = UIImagePickerController()
    var photoArray: [PhotoObject]?
    var array: [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        self.photoArray = PhotoObjectManager.shared.getPhotoObject()
    }
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        
        self.showAlert(title: "Добавить фото в галерею", message: "Выберете фотографию из вашей галереи либо сделайте фотографию.", prefferedStyle: .actionSheet, firstButtonText: "Фотопленка", firstButtonStyle: .default, firstButtonAction: { (_) in
            self.pickPhoto()
        }, secondButtonText: "Камера", secondButtonStyle: .default, secondButtonAction: { (_) in
            self.pickCamera()
        }, thirdButtonText: "Отмена", thirdButtonStyle: .destructive) { (_) in
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func pickCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    func pickPhoto(){
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
        
    }
    
    
}

extension MainViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage {
            
            let url = PhotoObjectManager.shared.saveImage(image: pickedImage)
            let photoObject = PhotoObject()
            photoObject.photo = url
            PhotoObjectManager.shared.setPhotoObject(photoObject: photoObject)
            self.photoArray = PhotoObjectManager.shared.getPhotoObject()
            self.collectionView.reloadData()
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell else {return UICollectionViewCell()}
        cell.setup(photoObject: photoArray?[indexPath.item])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photoController = self.storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController else {return}
        
        photoController.photoArray = self.photoArray ?? []
        photoController.element = indexPath
        
        self.navigationController?.pushViewController(photoController, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = self.view.frame.size.width
        return CGSize(width: screenWidth / 3, height: screenWidth / 3)
    }
}
