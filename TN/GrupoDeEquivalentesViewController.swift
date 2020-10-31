//Pantalla en donde se muestra el menu de equivalencia para poder mostrar la de cada categoria en otra pantalla

import UIKit

class GrupoDeEquivalentesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
     var listaMenus = ["VEGETALES", "LECHE", "CARNES", "AZUCARES", "LEGUMINOSAS", "FRUTAS", "CEREALES", "GRASAS"]
     var Titulo : String!

     override func viewDidLoad() {
         super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

         // Do any additional setup after loading the view.
     }
     
     //Funciones de TableView
     func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return listaMenus.count
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
     
    // dependiendo de lo seleccionado se llama su segue para poder mostrarlo en grupoReferencia
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
         cell.textLabel?.text = listaMenus[indexPath.row]

        if(indexPath.row == 0){
        cell.imageView?.image = UIImage(named: "vegetales")
        }
        if(indexPath.row == 1){
        cell.imageView?.image = UIImage(named: "leche")
        }
        if(indexPath.row == 2){
        cell.imageView?.image = UIImage(named: "carnes")
        }
        if(indexPath.row == 3){
        cell.imageView?.image = UIImage(named: "azucares")
        }
        if(indexPath.row == 4){
        cell.imageView?.image = UIImage(named: "leguminosas")
        }
        if(indexPath.row == 5){
        cell.imageView?.image = UIImage(named: "frutas")
        }
        if(indexPath.row == 6){
        cell.imageView?.image = UIImage(named: "cereales")
        }
        if(indexPath.row == 7){
        cell.imageView?.image = UIImage(named: "grasas")
        }
        
        

         return cell
     }
    
    
    @IBAction func quitaView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
     
    

     
     // MARK: - Navigation

     //Prepare para poder mandar el titulo seleccionado para filtrar la seleccion a los datos  mostrar
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         if segue.identifier == "Referencia"{
         let vistaDetalle = segue.destination as! GrupoReferenciaViewController
         let indice = tableView.indexPathForSelectedRow!
         vistaDetalle.title = "Lista de Equivalentes"
         vistaDetalle.Titulo = listaMenus[indice.row]
         }
         
     }

}
