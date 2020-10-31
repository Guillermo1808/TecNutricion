//pantalla que muetsra los recetario para poder selccionar el que quieres abrir

import UIKit

class MenuPdfsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var listaMenus = ["Desayuno, comida y cena", "Vegetarianos", "Ensaladas", "Antojos", "Smoothies"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(red: 69/255, green: 180/255, blue: 190/255, alpha: 1)
        view.backgroundColor = UIColor(red: 69/255, green: 180/255, blue: 190/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //Funciones del tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaMenus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Receta", for: indexPath)
        cell.textLabel?.text = listaMenus[indexPath.row]
        cell.tintColor = .white
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(red: 83/255, green: 216/255, blue: 228/255, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    @IBAction func quitaView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // Segues dependiendo de lo que se selecciono
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vistaDetalle = segue.destination as! PDFsViewController
        let indice = tableView.indexPathForSelectedRow!
        
        if indice.row == 0 {
            vistaDetalle.Titulo = "RecetarioComidas"
        }
        
        if indice.row == 1 {
            vistaDetalle.Titulo = "RecetarioVeg"
        }
        
        if indice.row == 2 {
            vistaDetalle.Titulo = "RecetarioEnsaladas"
        }
        
        if indice.row == 3 {
            vistaDetalle.Titulo = "RecetarioAntojos"
        }
        
        if indice.row == 4 {
            vistaDetalle.Titulo = "RecetarioSmoothies"
        }
    }
    
    //Funciones para quitar elimentos del navigation controller
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
