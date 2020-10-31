//Pantalla en donde muestra los datos del usuario que se guardan por medio de defaults

import UIKit

class MiPerfilViewController: UIViewController {

    //outlets
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfEdad: UITextField!
    @IBOutlet weak var tfSexo: UITextField!
    @IBOutlet weak var tfAltura: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //para que el usuario no pueda modifcar en esa pantalla
        tfNombre.isUserInteractionEnabled = false
        tfEdad.isUserInteractionEnabled = false
        tfAltura.isUserInteractionEnabled = false
        tfSexo.isUserInteractionEnabled = false
        actualizaInterfaz()
    }
    
    
    func cambiaSexo(claveSexo: Int) {
        
        
        
        switch claveSexo{
        case 0:  // Hombre
            tfSexo.text = "Hombre"
        case 1:  // Mujer
            tfSexo.text = "Mujer"
        default:  //
            tfSexo.text = ""
        }
        
    }
    //funcion que actualzia los datos a mostrar en pantalla por medio de defaults
    func actualizaInterfaz() {
        let defaults = UserDefaults.standard
        if let nom = defaults.value(forKey: "nombre") as? String{
            tfNombre.text = nom
        }
        if let alt = defaults.value(forKey: "altura") as? String{
            tfAltura.text = alt
        }
        let valorEdad = defaults.float(forKey: "edad")
        tfEdad.text = String(Int(valorEdad))
        
        let valorSexo = defaults.integer(forKey: "claveSexo")
        cambiaSexo(claveSexo: valorSexo)
        //let valorSexo = defaults.bool(forKey: "claveSexo")
        //tfSexo.text = String(valorSexo)
        
        
    }
    
    //undwind de la pantalla en donde se agregan los datos y los actualiza
    @IBAction func unwindSettings( segue : UIStoryboardSegue){
        actualizaInterfaz()
    }
    
    @IBAction func quitaView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}

