
import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    var rightPhotoImageView = UIImageView()
    var leftPhotoImageView = UIImageView()
    var photoArray = [PhotoObject]()
    var element = IndexPath()
    var leftCounter: Int = 0
    var rightCounter: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure(customPhoto: photoArray[element.row])
        self.leftSwipeSetting()
        self.rightSwipeSetting()
    }
    
    
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer){
        
        if element.row == photoArray.count - 1 {
            element.row = 0
        }else{
            element.row += 1
        }
        
        self.configure(customPhoto: self.photoArray[self.element.row])
        
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer){
        if element.row == 0{
            element.row = photoArray.count - 1
        }else{
            element.row -= 1
        }
        
        self.configure(customPhoto: photoArray[element.row])
    }
    
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        
        if photoArray[element.row].isFavorite == false {
            photoArray[element.row].isFavorite = true
            likeButton.setBackgroundImage(UIImage(named:"heart_true"), for: .normal)
            PhotoObjectManager.shared.setPhotoObject(photoObject: photoArray[element.row])
        }else if photoArray[element.row].isFavorite == true{
            photoArray[element.row].isFavorite = false
            likeButton.setBackgroundImage(UIImage(named:"heart_false"), for: .normal)
            PhotoObjectManager.shared.setPhotoObject(photoObject: photoArray[element.row])
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func leftSwipeSetting(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipe(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    func rightSwipeSetting(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    func configure(customPhoto: PhotoObject){
        let photo = PhotoObjectManager.shared.loadSave(fileName: customPhoto.photo ?? "" )
        photoImageView.image = photo
        if customPhoto.isFavorite == true {
            likeButton.setBackgroundImage(UIImage(named:"heart_true"), for: .normal)
        }else if customPhoto.isFavorite == false{
            likeButton.setBackgroundImage(UIImage(named:"heart_false"), for: .normal)
        }
        commentLabel.text = customPhoto.comment
    }
    
}
