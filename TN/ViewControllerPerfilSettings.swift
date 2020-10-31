//Panatalla en donde se pueden modificar los valores del perfil del usuario en donde tambien se utiliza un slider

import UIKit

class ViewControllerPerfilSettings: UIViewController {

    
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var sliderEdad: UISlider!
    @IBOutlet weak var segmentedSexo: UISegmentedControl!
    @IBOutlet weak var tfAltura: UITextField!
    @IBOutlet weak var lbEdad: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        sliderEdad.maximumValue = 80
        //sliderEdad.isContinuous = false
        
        
        if let nom = defaults.value(forKey: "nombre") as? String {
            tfNombre.text = nom
        }
        if let alt = defaults.value(forKey: "altura") as? String {
            tfAltura.text = alt
        }
        sliderEdad.value = defaults.float(forKey: "edad")
        segmentedSexo.selectedSegmentIndex = defaults.integer(forKey: "claveSexo")
        
        lbEdad.text = String(Int(sliderEdad.value))
        
        tfAltura.keyboardType = UIKeyboardType.numberPad
    }
    
    @IBAction func slider(_ sender: UISlider) {
        lbEdad.text = String(Int(sender.value))
    }
    
    
    @IBAction func Confirma(_ sender: UIButton) {
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //defaults para guardar los datos
        let defaults = UserDefaults.standard
            
            defaults.set(tfNombre.text, forKey: "nombre")
            defaults.set(tfAltura.text, forKey: "altura")
            defaults.set(segmentedSexo.selectedSegmentIndex, forKey: "claveSexo")
            defaults.set(sliderEdad.value, forKey: "edad")
            
        }
    
    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
