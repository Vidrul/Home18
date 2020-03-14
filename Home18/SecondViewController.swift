
import UIKit


protocol SecondViewControllerDelegate: NSObject {
    func music (music: Music)
}

class SecondViewController: UIViewController {

    @IBOutlet weak var songNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var syleTextField: UITextField!
    
    
    var delegate:SecondViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func AddMusicButtonDidClick(_ sender: UIButton) {
        
        let songName = songNameTextField.text!
        let artistName = artistNameTextField.text!
        let style = syleTextField.text!
        
        let song = Music(nameSong: songName, artistName: artistName, style: style)
        delegate?.music(music: song)
        navigationController?.popViewController(animated: true)
    }
    

}
