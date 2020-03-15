
import UIKit


protocol SecondViewControllerDelegate: NSObject {
    func music (music: Music)
}

class SecondViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var songNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var syleTextField: UITextField!
    
    @IBOutlet weak var songImage: UIImageView!
    
    var delegate:SecondViewControllerDelegate?
    let pickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerController.delegate = self 
        
    }
    
    @IBAction func AddMusicButtonDidClick(_ sender: UIButton) {
        
        let songName = songNameTextField.text!
        let artistName = artistNameTextField.text!
        let style = syleTextField.text!
        let image = songImage.image!
        
        let song = Music(nameSong: songName, artistName: artistName, style: style,image: image)
        delegate?.music(music: song)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImageButtondidClick(_ sender: UIButton) {
        let alertController = UIAlertController(title: "What to open?", message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Library", style: .default, handler: { (_
            ) in
            self.pickerController.allowsEditing = true
            self.pickerController.sourceType = .photoLibrary
            
            self.present(self.pickerController, animated: true, completion: nil)
        }))
        present(alertController, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            songImage.image = image
        }
        pickerController.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case songNameTextField:
            artistNameTextField.becomeFirstResponder()
        case artistNameTextField:
            syleTextField.becomeFirstResponder()
        case syleTextField:
            syleTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}


