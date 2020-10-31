//Tabla que utiliza el pod SideMenu para mostrar sus datos

import UIKit

class MenuTableViewController: UITableViewController {

    //opciones del menu
    var opciones = ["Plan Nutricional", "¿Cómo voy?", "Grupo de Equivalentes", "Composición Corporal", "Mi Perfil", "Semaforo Nutricional", "Recetas", "Creditos"]
    //colores del menu
    let colorTest = UIColor(red:69/255.0, green: 180/255, blue: 190/255, alpha: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Color del MENU
        tableView.backgroundColor = colorTest
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source

    //Funciones del TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opciones.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = opciones[indexPath.row]
        //Color de las opciones de MENU
        cell.textLabel?.textColor = .white
        cell.backgroundColor = colorTest
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if indexPath.row == 0{
            performSegue(withIdentifier: "PlanNutricional", sender: Any?.self)
        }
        
        if indexPath.row == 1{
            performSegue(withIdentifier: "ComoVoy", sender: Any?.self)
        }
        
        if indexPath.row == 2{
            performSegue(withIdentifier: "GrupoDeEquivalentes", sender: Any?.self)
        }
        
        if indexPath.row == 3{
            performSegue(withIdentifier: "ComposicionCorporal", sender: Any?.self)
        }
        
        if indexPath.row == 4{
            performSegue(withIdentifier: "MiPerfil", sender: Any?.self)
        }
        
        if indexPath.row == 5{
            performSegue(withIdentifier: "Semaforo", sender: Any?.self)
        }
        
        if indexPath.row == 6{
            performSegue(withIdentifier: "PDFs", sender: Any?.self)
        }
        
        if indexPath.row == 7{
            performSegue(withIdentifier: "Creditos", sender: Any?.self)
        }
        
    }

}





