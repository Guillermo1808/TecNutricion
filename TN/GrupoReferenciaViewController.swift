//Pantalla en donde muestra dependiendo de los seleccionado en la pantalla de equivalencias, en donde dependendiendo de lo seleccionado muestra la informacion

import UIKit

struct Grupos {
    var nombre: String
    var equivalente: String
}

class ReferenciaTableViewCell: UITableViewCell{
    
    @IBOutlet weak var lbGrupo: UILabel!
    @IBOutlet weak var lbEquivalencia: UILabel!
    
}

class GrupoReferenciaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lbTitulo: UILabel!
    @IBOutlet weak var tableView: UITableView!
      
    var Titulo : String!
    var renglones : Int = 0
    
    
     
      
      var listaVegetales = [Grupos(nombre: "Acelga", equivalente: "1/2 taza"), Grupos(nombre: "Alcachofas", equivalente: "1/2 taza"), Grupos(nombre: "Apio", equivalente: "1/2 taza"), Grupos(nombre: "Berenjena", equivalente: "1/2 taza"), Grupos(nombre: "Brocoli", equivalente: "1/2 taza"), Grupos(nombre: "Cebolla", equivalente: "1/2 taza"), Grupos(nombre: "Cilantro", equivalente: "1/2 taza"), Grupos(nombre: "Coliflor", equivalente: "1/2 taza"), Grupos(nombre: "Betabel", equivalente: "1/2 taza"), Grupos(nombre: "Chile poblano", equivalente: "1/2 taza"), Grupos(nombre: "Jugo de tomate", equivalente: "1/2 taza"), Grupos(nombre: "Champinones", equivalente: "1/2 taza"), Grupos(nombre: "Chayote", equivalente: "1/2 taza"), Grupos(nombre: "Ejotes", equivalente: "1/2 taza"), Grupos(nombre: "Espinacas", equivalente: "1/2 taza"), Grupos(nombre: "Flor de calabaza", equivalente: "1/2 taza"), Grupos(nombre: "Jitomate", equivalente: "1/2 taza"), Grupos(nombre: "Lechuga", equivalente: "1/2 taza"), Grupos(nombre: "Nopales", equivalente: "1/2 taza"), Grupos(nombre: "Calabacita", equivalente: "1/2 taza"), Grupos(nombre: "Pimiento", equivalente: "1/2 taza"), Grupos(nombre: "Jugo de verduras", equivalente: "1/2 taza"), Grupos(nombre: "Ensalada promedio", equivalente: "1/2 taza"), Grupos(nombre: "Pepino", equivalente: "1/2 taza"), Grupos(nombre: "Perejil", equivalente: "1/2 taza"), Grupos(nombre: "Rabano", equivalente: "1/2 taza"), Grupos(nombre: "Repollo", equivalente: "1/2 taza"), Grupos(nombre: "Jicama", equivalente: "1/2 taza"), Grupos(nombre: "Tomate", equivalente: "1/2 taza"), Grupos(nombre: "Esparragos", equivalente: "1/2 taza"), Grupos(nombre: "Cebolla", equivalente: "1/2 taza"), Grupos(nombre: "Zanahoria", equivalente: "1/2 taza"), Grupos(nombre: "Germen", equivalente: "1/2 taza")]
      var listaLeche = [Grupos(nombre: "Leche de vaca o soya", equivalente: "1 taza"), Grupos(nombre: "Yogurth", equivalente: "1 taza")]
      var listaCarnes = [Grupos(nombre: "Aves", equivalente: "30 grs."), Grupos(nombre: "Res", equivalente: "30 grs."), Grupos(nombre: "Pescados y Mariscos", equivalente: "30 grs."), Grupos(nombre: "Pollo Deshebrado", equivalente: "1/4 taza"), Grupos(nombre: "Queso cotagge o requeson", equivalente: "3 C"), Grupos(nombre: "Queso fresco", equivalente: "40 g."), Grupos(nombre: "Atun en agua", equivalente: "1/3 lata"), Grupos(nombre: "Carnes frias", equivalente: "2 reb. chicas"), Grupos(nombre: "Salchicha", equivalente: "1 pza."), Grupos(nombre: "Huevo", equivalente: "1 pza."), Grupos(nombre: "Clara de huevo", equivalente: "2 pza.")]
      var listaAzucares = [Grupos(nombre: "Azucar", equivalente: "1 C"), Grupos(nombre: "Miel", equivalente: "1 C"), Grupos(nombre: "Mermelada", equivalente: "1 C"), Grupos(nombre: "Yakult", equivalente: "1 C (80ml.)"), Grupos(nombre: "Cajeta", equivalente: "1 C"), Grupos(nombre: "Gelatina regular", equivalente: "1/4 taza"), Grupos(nombre: "Chocolate en Polvo", equivalente: "1 C"), Grupos(nombre: "Refrescos", equivalente: "1/4 lata"), Grupos(nombre: "Catsup", equivalente: "1 C")]
      var listaLeguminosas = [Grupos(nombre: "Lentejas", equivalente: "1/2 taza"), Grupos(nombre: "Habas", equivalente: "1/2 taza"), Grupos(nombre: "Garbanzo", equivalente: "1/2 taza"), Grupos(nombre: "Alubias", equivalente: "1/2 taza"), Grupos(nombre: "Frijol cocido o en bola", equivalente: "1/2 taza"), Grupos(nombre: "Frijol refrito", equivalente: "1/3 taza"), Grupos(nombre: "Soya texturizada", equivalente: "3 C"), Grupos(nombre: "Soya cocida", equivalente: "1/3 taza")]
      var listaFrutas = [Grupos(nombre: "Arandanos", equivalente: "2 C"), Grupos(nombre: "Ciruela", equivalente: "3 piezas"), Grupos(nombre: "Chabacano", equivalente: "4 piezas"), Grupos(nombre: "Durazno", equivalente: "2 piezas"), Grupos(nombre: "Fresa", equivalente: "1 taza"), Grupos(nombre: "Guayaba", equivalente: "2 med."), Grupos(nombre: "Jugo de frutas", equivalente: "1/2 taza"), Grupos(nombre: "Jugo de uva", equivalente: "1/4 taza"), Grupos(nombre: "Limon", equivalente: "libre"), Grupos(nombre: "Mandarina", equivalente: "2 piezas"), Grupos(nombre: "Mango", equivalente: "1/2 med."), Grupos(nombre: "Kiwi", equivalente: "1 1/2 piezas"), Grupos(nombre: "Manzana", equivalente: "1 piezas"), Grupos(nombre: "Melon", equivalente: "1 taza"), Grupos(nombre: "Naranja", equivalente: "1 piezas"), Grupos(nombre: "Papaya", equivalente: "2/3 taza"), Grupos(nombre: "Pera", equivalente: "1/2 piezas"), Grupos(nombre: "Pina", equivalente: "2/3 taza"), Grupos(nombre: "Platano", equivalente: "1/2 piezas"), Grupos(nombre: "Sandia", equivalente: "1 taza"), Grupos(nombre: "Toronja", equivalente: "1 piezas"), Grupos(nombre: "Tuna", equivalente: "2 piezas"), Grupos(nombre: "Uva", equivalente: "9 piezas"), Grupos(nombre: "Pasitas", equivalente: "10 piezas")]
      var listaCereales = [Grupos(nombre: "Cereal sin endulzar", equivalente: "1/2 taza"), Grupos(nombre: "Arroz cocido", equivalente: "1/2 taza"), Grupos(nombre: "Amaranto tostado", equivalente: "1/3 taza"), Grupos(nombre: "Avena cocida", equivalente: "1/2 taza"), Grupos(nombre: "Avena cruda", equivalente: "1/3 taza"), Grupos(nombre: "Salvado y germen de trigo", equivalente: "1/2 taza"), Grupos(nombre: "Pasta cocida", equivalente: "1/2 taza"), Grupos(nombre: "Harina /maizena", equivalente: "2 C"), Grupos(nombre: "Pan de barra integral", equivalente: "1 reb"), Grupos(nombre: "Pan p/hot dog", equivalente: "1/2 pieza"), Grupos(nombre: "Galletas saladas", equivalente: "6 cuadros"), Grupos(nombre: "Kraker Bran", equivalente: "3 cuadros"), Grupos(nombre: "Galletas Habaneras", equivalente: "3 piezas"), Grupos(nombre: "Galletas Marias", equivalente: "4 piezas"), Grupos(nombre: "Elote desgranado", equivalente: "1/2 taza"), Grupos(nombre: "Elote mazorca", equivalente: "3/4 pieza"), Grupos(nombre: "Papa c/ cascara", equivalente: "1/2 pieza"), Grupos(nombre: "Granola (simple)", equivalente: "3 C"), Grupos(nombre: "Tortilla maiz", equivalente: "1 pieza"), Grupos(nombre: "Tostada Horneada", equivalente: "2 pieza"), Grupos(nombre: "Pan p/hamburguesa chico", equivalente: "1/2 pieza"), Grupos(nombre: "Pan p/hamburguesa grande", equivalente: "1/3 pieza"), Grupos(nombre: "Frances s/migajon", equivalente: "1/2 pieza"), Grupos(nombre: "Frances c/migajon", equivalente: "1/4 pieza"), Grupos(nombre: "Crotones", equivalente: "1/2 taza"), Grupos(nombre: "Palomitas naturales", equivalente: "2 tazas")]
      var listaGrasas = [Grupos(nombre: "Aceite", equivalente: "1 C"), Grupos(nombre: "Queso Crema", equivalente: "1 C"), Grupos(nombre: "Crema", equivalente: "1 C"), Grupos(nombre: "Guacamole", equivalente: "2 C"), Grupos(nombre: "Cacahuate", equivalente: "18 piezas"), Grupos(nombre: "Semillas de girasol o calabaza", equivalente: "1 1/2 C"), Grupos(nombre: "Pinones", equivalente: "2 C"), Grupos(nombre: "Mantequilla", equivalente: "1 C"), Grupos(nombre: "Leche de almendras", equivalente: "250 ml"), Grupos(nombre: "Mayonesa", equivalente: "1 C"), Grupos(nombre: "Nuez", equivalente: "3 piezas"), Grupos(nombre: "Pistaches", equivalente: "6 piezas"), Grupos(nombre: "Almendra", equivalente: "10 piezas"), Grupos(nombre: "Aguacate", equivalente: "1/4 pieza"), Grupos(nombre: "Aceitunas", equivalente: "6 piezas"), Grupos(nombre: "Cocoa", equivalente: "2 C"), Grupos(nombre: "Aderezo", equivalente: "1 C")]
      
      override func viewDidLoad() {
          super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isUserInteractionEnabled = true
          

          lbTitulo.text = Titulo
          
          if Titulo == "VEGETALES"{
              renglones = listaVegetales.count
            view.backgroundColor = UIColor(red: 117/255, green: 184/255, blue: 98/255, alpha: 1)
          }
          else if Titulo == "LECHE"{
              renglones = listaLeche.count
            view.backgroundColor = UIColor(red: 235/255, green: 194/255, blue: 156/255, alpha: 1)
          }
          else if Titulo == "CARNES"{
              renglones = listaCarnes.count
            view.backgroundColor = UIColor(red: 149/255, green: 65/255, blue: 158/255, alpha: 1)
          }
          else if Titulo == "AZUCARES"{
              renglones = listaAzucares.count
            view.backgroundColor = UIColor(red: 234/255, green: 139/255, blue: 180/255, alpha: 1)
          }
          else if Titulo == "LEGUMINOSAS"{
              renglones = listaLeguminosas.count
            view.backgroundColor = UIColor(red: 235/255, green: 120/255, blue: 25/255, alpha: 1)
          }
          else if Titulo == "FRUTAS"{
              renglones = listaFrutas.count
            view.backgroundColor = UIColor(red: 181/255, green: 47/255, blue: 63/255, alpha: 1)
          }
          else if Titulo == "CEREALES"{
              renglones = listaCereales.count
            view.backgroundColor = UIColor(red: 235/255, green: 190/255, blue: 56/255, alpha: 1)
          }
          else if Titulo == "GRASAS"{
              renglones = listaGrasas.count
            view.backgroundColor = UIColor(red: 174/255, green: 122/255, blue: 74/255, alpha: 1)
          }
        
      }
      

      func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
          return renglones
      }
      
    //Dependiedo de lo seleccionado muestra la informacion y le da color a la tabla
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReferenciaTableViewCell
          
          if Titulo == "VEGETALES"{
              let grupo = listaVegetales[indexPath.row]
              cell.lbGrupo.text = grupo.nombre
              cell.lbEquivalencia.text = grupo.equivalente
            tableView.backgroundColor = UIColor(red: 137/255, green: 204/255, blue: 118/255, alpha: 0.5)
            cell.backgroundColor = UIColor(red: 137/255, green: 204/255, blue: 118/255, alpha: 0.5)
          }
          else if Titulo == "LECHE"{
              let grupo = listaLeche[indexPath.row]
              cell.lbGrupo.text = grupo.nombre
              cell.lbEquivalencia.text = grupo.equivalente
            tableView.backgroundColor = UIColor(red: 255/255, green: 214/255, blue: 176/255, alpha: 0.5)
            cell.backgroundColor = UIColor(red: 255/255, green: 214/255, blue: 176/255, alpha: 0.5)
            
          }
          else if Titulo == "CARNES"{
              let grupo = listaCarnes[indexPath.row]
              cell.lbGrupo.text = grupo.nombre
              cell.lbEquivalencia.text = grupo.equivalente
            tableView.backgroundColor = UIColor(red: 169/255, green: 85/255, blue: 178/255, alpha: 0.5)
            cell.backgroundColor = UIColor(red: 169/255, green: 85/255, blue: 178/255, alpha: 0.5)
          }
          else if Titulo == "AZUCARES"{
              let grupo = listaAzucares[indexPath.row]
              cell.lbGrupo.text = grupo.nombre
              cell.lbEquivalencia.text = grupo.equivalente
            tableView.backgroundColor = UIColor(red: 254/255, green: 159/255, blue: 200/255, alpha: 0.5)
            cell.backgroundColor = UIColor(red: 254/255, green: 159/255, blue: 200/255, alpha: 0.5)
          }
          else if Titulo == "LEGUMINOSAS"{
              let grupo = listaLeguminosas[indexPath.row]
              cell.lbGrupo.text = grupo.nombre
              cell.lbEquivalencia.text = grupo.equivalente
            tableView.backgroundColor = UIColor(red: 255/255, green: 130/255, blue: 45/255, alpha: 0.5)
            cell.backgroundColor = UIColor(red: 255/255, green: 130/255, blue: 45/255, alpha: 0.5)
          }
          else if Titulo == "FRUTAS"{
              let grupo = listaFrutas[indexPath.row]
              cell.lbGrupo.text = grupo.nombre
              cell.lbEquivalencia.text = grupo.equivalente
            tableView.backgroundColor = UIColor(red: 201/255, green: 67/255, blue: 83/255, alpha: 0.5)
            cell.backgroundColor = UIColor(red: 201/255, green: 67/255, blue: 83/255, alpha: 0.5)
          }
          else if Titulo == "CEREALES"{
              let grupo = listaCereales[indexPath.row]
              cell.lbGrupo.text = grupo.nombre
              cell.lbEquivalencia.text = grupo.equivalente
            tableView.backgroundColor = UIColor(red: 255/255, green: 210/255, blue: 76/255, alpha: 0.5)
            cell.backgroundColor = UIColor(red: 255/255, green: 210/255, blue: 76/255, alpha: 0.5)
          }
          else if Titulo == "GRASAS"{
              let grupo = listaGrasas[indexPath.row]
              cell.lbGrupo.text = grupo.nombre
              cell.lbEquivalencia.text = grupo.equivalente
            tableView.backgroundColor = UIColor(red: 194/255, green: 142/255, blue: 94/255, alpha: 0.5)
            cell.backgroundColor = UIColor(red: 194/255, green: 142/255, blue: 94/255, alpha: 0.5)
          }
          return cell
      }

    @IBAction func quitaView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
