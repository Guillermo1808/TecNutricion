//Clase codable para guardar los datos de dia, en donde se guardan los acumulados y los planeados para poder utilizarlos en las graficas de Pie en comovoy y Tudia

import UIKit

class Dia: Codable {
    var dia: String
    
    var agua: Int
    var vegetales: Int
    var carnes: Int
    var frutas: Int
    var cereales: Int
    var grasas: Int
    var leche: Int
    var azucares: Int
    var leguminosas: Int
    
    var aguaP: Int
    var vegetalesP: Int
    var carnesP: Int
    var frutasP: Int
    var cerealesP: Int
    var grasasP: Int
    var lecheP: Int
    var azucaresP: Int
    var leguminosasP: Int
    
    init(dia: String, agua: Int, vegetales: Int, carnes: Int, frutas: Int, cereales: Int, grasas: Int, leche: Int, azucares: Int, leguminosas: Int, aguaP: Int, vegetalesP: Int, carnesP: Int, frutasP: Int, cerealesP: Int, grasasP: Int, lecheP: Int, azucaresP: Int, leguminosasP: Int) {
        self.dia = dia
        self.agua = agua
        self.vegetales = vegetales
        self.carnes = carnes
        self.frutas = frutas
        self.cereales = cereales
        self.grasas = grasas
        self.leche = leche
        self.azucares = azucares
        self.leguminosas = leguminosas
        
        self.aguaP = aguaP
        self.vegetalesP = vegetalesP
        self.carnesP = carnesP
        self.frutasP = frutasP
        self.cerealesP = cerealesP
        self.grasasP = grasasP
        self.lecheP = lecheP
        self.azucaresP = azucaresP
        self.leguminosasP = leguminosasP
    }
}
