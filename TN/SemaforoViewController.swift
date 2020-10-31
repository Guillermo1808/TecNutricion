//Pantalla en donde se muestran dos imagenes sobre el semaforo

import UIKit

class SemaforoViewController: UIViewController {

    
    @IBOutlet weak var imgSemaforo: UIImageView!
    @IBOutlet weak var imgEjemplo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgSemaforo.image = UIImage(named: "semaforoNut")
        imgEjemplo.image = UIImage(named: "semaforoNutEj")
        // Do any additional setup after loading the view.
    }
    

    @IBAction func quitaView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
