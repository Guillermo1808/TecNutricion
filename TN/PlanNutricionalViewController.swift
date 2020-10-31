//Pantalla en donde se actualzia el plan nuticional y se guarda en user defaults para poder utilizarlos en las demas pantallas

import UIKit

class PlanNutricionalViewController: UIViewController {

    //Outlets
    @IBOutlet weak var imgVegetales: UIImageView!
    @IBOutlet weak var imgLeche: UIImageView!
    @IBOutlet weak var imgCarnes: UIImageView!
    @IBOutlet weak var imgAzucares: UIImageView!
    @IBOutlet weak var imgCereales: UIImageView!
    @IBOutlet weak var imgLeguminosas: UIImageView!
    @IBOutlet weak var imgFrutas: UIImageView!
    @IBOutlet weak var imgGrasas: UIImageView!
    @IBOutlet weak var imgAgua: UIImageView!
    @IBOutlet weak var txtVegetales: UITextField!
    @IBOutlet weak var txtLeche: UITextField!
    @IBOutlet weak var txtCarnes: UITextField!
    @IBOutlet weak var txtCereales: UITextField!
    @IBOutlet weak var txtLeguminosas: UITextField!
    @IBOutlet weak var txtFrutas: UITextField!
    @IBOutlet weak var txtGrasas: UITextField!
    @IBOutlet weak var txtAgua: UITextField!
    @IBOutlet weak var txtAzucares: UITextField!
    
    var vegetales = 0
    var leche = 0
    var carnes = 0
    var azucares = 0
    var cereales = 0
    var leguminosas = 0
    var frutas = 0
    var grasas = 0
    var agua = 8



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // carga las imagenes en la pantalla
        imgVegetales.image = UIImage(named: "vegetales")
        imgLeche.image = UIImage(named: "leche")
        imgCarnes.image = UIImage(named: "carnes")
        imgAzucares.image = UIImage(named: "azucares")
        imgCereales.image = UIImage(named: "cereales")
        imgLeguminosas.image = UIImage(named: "leguminosas")
        imgFrutas.image = UIImage(named: "frutas")
        imgGrasas.image = UIImage(named: "grasas")
        imgAgua.image = UIImage(named: "agua")
        
        //carga los txr fields en 0
        txtVegetales.text = String(vegetales)
        txtLeche.text = String(leche)
        txtCarnes.text = String(carnes)
        txtAzucares.text = String(azucares)
        txtCereales.text = String(cereales)
        txtLeguminosas.text = String(leguminosas)
        txtFrutas.text = String(frutas)
        txtGrasas.text = String(grasas)
        txtAgua.text = String(agua)
        actualizaPlanNutricional()
        
        // nada mas se peude usar numeros
        txtVegetales.keyboardType = UIKeyboardType.numberPad
        txtLeche.keyboardType = UIKeyboardType.numberPad
        txtCarnes.keyboardType = UIKeyboardType.numberPad
        txtAzucares.keyboardType = UIKeyboardType.numberPad
        txtCereales.keyboardType = UIKeyboardType.numberPad
        txtLeguminosas.keyboardType = UIKeyboardType.numberPad
        txtFrutas.keyboardType = UIKeyboardType.numberPad
        txtGrasas.keyboardType = UIKeyboardType.numberPad
        txtAgua.keyboardType = UIKeyboardType.numberPad
        
    }
    
    
    //Funcion para quitar teclado
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

    @IBAction func quitaView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //funcion que guarda los datos en user defaults
    @IBAction func gurdarDatos(_ sender: UIButton) {
        let defaults = UserDefaults.standard

        if(txtVegetales.text == "" || txtLeche.text == "" || txtCarnes.text == "" || txtAzucares.text == "" || txtCereales.text == "" || txtLeguminosas.text == "" || txtFrutas.text == "" || txtGrasas.text == "" || txtAgua.text == "" ) {
            let alert = UIAlertController(title: "ERROR", message: "Todos los campos deben estar llenos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else{
            defaults.set(txtVegetales.text, forKey: "Vegetales")
            defaults.set(txtLeche.text, forKey: "Leche")
            defaults.set(txtCarnes.text, forKey: "Carnes")
            defaults.set(txtAzucares.text, forKey: "Azucares")
            defaults.set(txtCereales.text, forKey: "Cereales")
            defaults.set(txtLeguminosas.text, forKey: "Leguminosas")
            defaults.set(txtFrutas.text, forKey: "Frutas")
            defaults.set(txtGrasas.text, forKey: "Grasas")
            defaults.set(txtAgua.text, forKey: "Agua")
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    //Funcion que carga los datos en caso de que haya suer defaults guradados
    func actualizaPlanNutricional(){
        let defaults = UserDefaults.standard
        
        if let veg = defaults.value(forKey: "Vegetales") as? String{
            txtVegetales.text = veg
        }
        if let lech = defaults.value(forKey: "Leche") as? String{
            txtLeche.text = lech
        }
        if let car = defaults.value(forKey: "Carnes") as? String{
            txtCarnes.text = car
        }
        if let azu = defaults.value(forKey: "Azucares") as? String{
            txtAzucares.text = azu
        }
        if let cer = defaults.value(forKey: "Cereales") as? String{
            txtCereales.text = cer
        }
        if let leg = defaults.value(forKey: "Leguminosas") as? String{
            txtLeguminosas.text = leg
        }
        if let fru = defaults.value(forKey: "Frutas") as? String{
            txtFrutas.text = fru
        }
        if let gra = defaults.value(forKey: "Grasas") as? String{
            txtGrasas.text = gra
        }
        if let agu = defaults.value(forKey: "Agua") as? String{
            txtAgua.text = agu
        }
    }
}
