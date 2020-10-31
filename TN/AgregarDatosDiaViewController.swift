//Pantalla en donde muestra las opciones a seleccionar para poder actualizar tu dia en los acumulados que se llevan y poder mantener un registro de ellos

import UIKit

class AgregarDatosDiaViewController: UIViewController {

    //outlets
    @IBOutlet weak var bttnAgua: UIButton!
    @IBOutlet weak var bttnFruta: UIButton!
    @IBOutlet weak var bttnCarne: UIButton!
    @IBOutlet weak var bttnCereal: UIButton!
    @IBOutlet weak var bttnGrasa: UIButton!
    @IBOutlet weak var bttnLeguminosas: UIButton!
    @IBOutlet weak var bttnVegetal: UIButton!
    @IBOutlet weak var bttnAzucar: UIButton!
    @IBOutlet weak var bttnLeche: UIButton!
    var cantidad = 1
    
    //Variables dentro del View para Agregar las cantidades
    @IBOutlet weak var viewModificarCantidades: UIView!
    @IBOutlet weak var imgAlimentoAgregar: UIImageView!
    @IBOutlet weak var txtCantidad: UITextField!
    
    var bttnID : Int!
    // Cantidades
    var aguaA = 0
    var vegetalesA = 0
    var carnesA = 0
    var frutasA = 0
    var cerealesA = 0
    var grasasA = 0
    var lecheA = 0
    var azucaresA = 0
    var leguminosasA = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Se cargan las imagenes a los botones y se da estilo a los labels que tienen para hacer mas visual los elementos agregados
        view.backgroundColor = UIColor(red: 246, green: 246, blue: 246, alpha: 1.0)
        viewModificarCantidades.backgroundColor  = UIColor(red: 246, green: 246, blue: 246, alpha: 1.0)
        viewModificarCantidades.isHidden = true
        txtCantidad.text = String(cantidad)
        cantidad = 1
        bttnID = -1
        bttnAgua.setBackgroundImage(UIImage(named: "agua"), for: .normal)
        bttnFruta.setBackgroundImage(UIImage(named: "frutas"), for: .normal)
        bttnCarne.setBackgroundImage(UIImage(named: "carnes"), for: .normal)
        bttnCereal.setBackgroundImage(UIImage(named: "cereales"), for: .normal)
        bttnGrasa.setBackgroundImage(UIImage(named: "grasas"), for: .normal)
        bttnLeguminosas.setBackgroundImage(UIImage(named: "leguminosas"), for: .normal)
        bttnVegetal.setBackgroundImage(UIImage(named: "vegetales"), for: .normal)
        bttnAzucar.setBackgroundImage(UIImage(named: "azucares"), for: .normal)
        bttnLeche.setBackgroundImage(UIImage(named: "leche"), for: .normal)
        
        bttnAgua.setTitleColor(.black, for: .normal)
        bttnFruta.setTitleColor(.black, for: .normal)
        bttnCarne.setTitleColor(.black, for: .normal)
        bttnCereal.setTitleColor(.black, for: .normal)
        bttnGrasa.setTitleColor(.black, for: .normal)
        bttnLeguminosas.setTitleColor(.black, for: .normal)
        bttnVegetal.setTitleColor(.black, for: .normal)
        bttnAzucar.setTitleColor(.black, for: .normal)
        bttnLeche.setTitleColor(.black, for: .normal)
        
    }
    

    //Funcion que agrega los elementos y actualiza las variables para el unwind de tuDia, tambien se actualiza el label para poder ayudar al usuario
   func agregar(){
        if(bttnID == 1){
            grasasA += cantidad
            bttnGrasa.tintColor = .black
            bttnGrasa.setTitle(String(grasasA), for: .normal)
            bttnGrasa.titleEdgeInsets = UIEdgeInsets(top: -60.0, left: 0.0, bottom: 0.0, right: 0.0)
            
        }
        if(bttnID == 2){
            lecheA += cantidad
            bttnLeche.tintColor = .black
            bttnLeche.setTitle(String(lecheA), for: .normal)
            bttnLeche.titleEdgeInsets = UIEdgeInsets(top: -60.0, left: 0.0, bottom: 0.0, right: 0.0)
            
        }
        if(bttnID == 3){
            vegetalesA += cantidad
            bttnVegetal.tintColor = .black
            bttnVegetal.setTitle(String(vegetalesA), for: .normal)
            bttnVegetal.titleEdgeInsets = UIEdgeInsets(top: -60.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
        if(bttnID == 4){
            frutasA += cantidad
            bttnFruta.tintColor = .black
            bttnFruta.setTitle(String(frutasA), for: .normal)
            bttnFruta.titleEdgeInsets = UIEdgeInsets(top: -60.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
        if(bttnID == 5){
            aguaA += cantidad
            bttnAgua.tintColor = .black
            bttnAgua.setTitle(String(aguaA), for: .normal)
            bttnAgua.titleEdgeInsets = UIEdgeInsets(top: -60.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
        if(bttnID == 6){
            cerealesA += cantidad
            bttnCereal.tintColor = .black
            bttnCereal.setTitle(String(cerealesA), for: .normal)
            bttnCereal.titleEdgeInsets = UIEdgeInsets(top: -60.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
        if(bttnID == 7){
            carnesA += cantidad
            bttnCarne.tintColor = .black
            bttnCarne.setTitle(String(carnesA), for: .normal)
            bttnCarne.titleEdgeInsets = UIEdgeInsets(top: -60.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
        if(bttnID == 8){
            azucaresA += cantidad
            bttnAzucar.tintColor = .black
            bttnAzucar.setTitle(String(azucaresA), for: .normal)
            bttnAzucar.titleEdgeInsets = UIEdgeInsets(top: -60.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
        if(bttnID == 9){
            leguminosasA += cantidad
            bttnLeguminosas.tintColor = .black
            bttnLeguminosas.setTitle(String(leguminosasA), for: .normal)
            bttnLeguminosas.titleEdgeInsets = UIEdgeInsets(top: -60.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
    }
    
    
    //Funciones de los botones que dependiendo de lo seleccionado abre el view con respectiva imagen en donde el usuario es capaz de agregar datos
    @IBAction func bttnGrasa(_ sender: UIButton) {
        cantidad = 1
        bttnID = 1
        txtCantidad.text = String(cantidad)
        viewModificarCantidades.isHidden = false
        imgAlimentoAgregar.image = bttnGrasa.backgroundImage(for: .normal)
        
    }
    
    @IBAction func bttnLeche(_ sender: UIButton) {
        cantidad = 1
        bttnID = 2
        txtCantidad.text = String(cantidad)
        viewModificarCantidades.isHidden = false
        imgAlimentoAgregar.image = bttnLeche.backgroundImage(for: .normal)
    }
    
    @IBAction func bttnVegetal(_ sender: UIButton) {
        cantidad = 1
        bttnID = 3
        txtCantidad.text = String(cantidad)
        viewModificarCantidades.isHidden = false
        imgAlimentoAgregar.image = bttnVegetal.backgroundImage(for: .normal)
    }
    
    @IBAction func bttnFruta(_ sender: UIButton) {
        cantidad = 1
        bttnID = 4
        txtCantidad.text = String(cantidad)
        viewModificarCantidades.isHidden = false
        imgAlimentoAgregar.image = bttnFruta.backgroundImage(for: .normal)
    }
    
    @IBAction func bttnAgua(_ sender: UIButton) {
        cantidad = 1
        bttnID = 5
        txtCantidad.text = String(cantidad)
        viewModificarCantidades.isHidden = false
        imgAlimentoAgregar.image = bttnAgua.backgroundImage(for: .normal)
    }
    
    @IBAction func bttnCereal(_ sender: UIButton) {
        cantidad = 1
        bttnID = 6
        txtCantidad.text = String(cantidad)
        viewModificarCantidades.isHidden = false
        imgAlimentoAgregar.image = bttnCereal.backgroundImage(for: .normal)
    }
    
    @IBAction func bttnCarne(_ sender: UIButton) {
        cantidad = 1
        bttnID = 7
        txtCantidad.text = String(cantidad)
        viewModificarCantidades.isHidden = false
        imgAlimentoAgregar.image = bttnCarne.backgroundImage(for: .normal)
    }
    
    @IBAction func bttnAzucar(_ sender: UIButton) {
        cantidad = 1
        bttnID = 8
        txtCantidad.text = String(cantidad)
        viewModificarCantidades.isHidden = false
        imgAlimentoAgregar.image = bttnAzucar.backgroundImage(for: .normal)
    }
    
    
    @IBAction func bttnLeguminosas(_ sender: UIButton) {
        cantidad = 1
        bttnID = 9
        txtCantidad.text = String(cantidad)
        viewModificarCantidades.isHidden = false
        imgAlimentoAgregar.image = bttnLeguminosas.backgroundImage(for: .normal)
    }
    
    
    @IBAction func bttnMas(_ sender: UIButton) {
        cantidad = cantidad+1
        txtCantidad.text = String(cantidad)
    }
    
    @IBAction func bttnMenos(_ sender: UIButton) {
        cantidad = cantidad-1
        txtCantidad.text = String(cantidad)
    }
    
    @IBAction func bttnListo(_ sender: UIButton) {
        viewModificarCantidades.isHidden = true
        agregar()
    }
    
    
      // MARK: - Navigation

      // In a storyboard-based application, you will often want to do a little preparation before navigation
      //Prepar par poder utilzar el undwind y guardar los datos acumulados
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          // Get the new view controller using segue.destination.
          // Pass the selected object to the new view controller.
          let vistaAgregar = segue.destination as! ViewController
        vistaAgregar.agua += aguaA
        vistaAgregar.azucares += azucaresA
        vistaAgregar.carnes += carnesA
        vistaAgregar.cereales += cerealesA
        vistaAgregar.frutas += frutasA
        vistaAgregar.vegetales += vegetalesA
        vistaAgregar.grasas += grasasA
        vistaAgregar.leguminosas += leguminosasA
        vistaAgregar.leche += lecheA
      }

}
