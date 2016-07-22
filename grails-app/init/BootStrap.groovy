import sumitel.Menu
import sumitel.Usuario
import sumitel.Articulo
import sumitel.Inventario

class BootStrap {

    def init = { servletContext ->

      def menuList = ['Compras', 'Clientes', 'Usuarios', 'Almacen', 'Inventario', 'Orden Compra', 'Notas Devolucion']
      menuList.each { obj -> 
        Menu menu = new Menu()
        menu.descripcionMenu = obj
        menu.save() 
      }

      Usuario u = new Usuario()
      u.nombre = 'Juan'
      u.apellido = 'Purata'
      u.login = 'admin'
      u.password = 'admin'
      u.usuarioCreacion = 'admin'
      u.fechaCreacion = new Date()
      u.save()


      List tuplas = [
        [articulo: 'AMIGO CHIP  NANO LTE  SANTI',   preciosub: 115, preciopub: 150, preciounitario: 50, totalarticulos: 16, costosub: 1840, costopub: 2400, costounitario: 2400],
        [articulo: 'AMIGO CHIP  NANOLTE TOLUCA',   preciosub: 115, preciopub: 150, preciounitario: 50, totalarticulos: 22, costosub: 2530, costopub: 3300, costounitario: 3300],
        [articulo: 'SIM CARD  TIP ',   preciosub: 80, preciopub: 150, preciounitario: 50, totalarticulos: 4, costosub: 320, costopub: 600, costounitario: 600],
        [articulo: 'ACER  410  NEGRO ',   preciosub: 1389, preciopub: 1499, preciounitario: 1295, totalarticulos: 3, costosub: 4167, costopub: 4497, costounitario: 4497],
        [articulo: 'ALCATEL 1050 NEGRO ',   preciosub: 190, preciopub: 199, preciounitario: 0, totalarticulos: 76, costosub: 14440, costopub: 15124, costounitario: 15124],
        [articulo: 'ALCATEL 4013 G',   preciosub: 759, preciopub: 799, preciounitario: 0, totalarticulos: 26, costosub: 19734, costopub: 20774, costounitario: 20774],
        [articulo: 'ALCATEL 6030 PLATA ',   preciosub: 1489, preciopub: 1599, preciounitario: 1369, totalarticulos: 15, costosub: 22335, costopub: 23985, costounitario: 23985],
        [articulo: 'ALCATEL 6030 ROSA ',   preciosub: 1489, preciopub: 1599, preciounitario: 1369, totalarticulos: 5, costosub: 7445, costopub: 7995, costounitario: 7995],
        [articulo: 'AMIGO CHIP TRIO SANTIAGO',   preciosub: 115, preciopub: 150, preciounitario: 50, totalarticulos: 199, costosub: 22885, costopub: 29850, costounitario: 29850],
        [articulo: 'AMIGO CHIP TRIO TOLUCA',   preciosub: 115, preciopub: 150, preciounitario: 50, totalarticulos: 23, costosub: 2645, costopub: 3450, costounitario: 3450],
        [articulo: 'AZUMI  T7 TABLET BCO',   preciosub: 919, preciopub: 999, preciounitario: 825, totalarticulos: 1, costosub: 919, costopub: 999, costounitario: 999],
        [articulo: 'AZUMI  T7 TABLET NEGRO',   preciosub: 919, preciopub: 999, preciounitario: 825, totalarticulos: 1, costosub: 919, costopub: 999, costounitario: 999],
        [articulo: 'EYO E 207 BCO LILA',   preciosub: 354, preciopub: 399, preciounitario: 0, totalarticulos: 19, costosub: 6726, costopub: 7581, costounitario: 7581],
        [articulo: 'EYO E 207 BCO ROSA',   preciosub: 354, preciopub: 399, preciounitario: 0, totalarticulos: 12, costosub: 4248, costopub: 4788, costounitario: 4788],
        [articulo: 'LANIX  106  BCO',   preciosub: 764, preciopub: 799, preciounitario: 682, totalarticulos: 21, costosub: 16044, costopub: 16779, costounitario: 16779],
        [articulo: 'LANIX  106  NEGRO ',   preciosub: 764, preciopub: 799, preciounitario: 682, totalarticulos: 6, costosub: 4584, costopub: 4794, costounitario: 4794],
        [articulo: 'LANIX  410  BLANCO',   preciosub: 935, preciopub: 999, preciounitario: 854, totalarticulos: 26, costosub: 24310, costopub: 25974, costounitario: 25974],
        [articulo: 'LANIX  410  NEGRO',   preciosub: 935, preciopub: 999, preciounitario: 854, totalarticulos: 1, costosub: 935, costopub: 999, costounitario: 999],
        [articulo: 'LANIX  600 NEGRO ',   preciosub: 1389, preciopub: 1499, preciounitario: 1295, totalarticulos: 15, costosub: 20835, costopub: 22485, costounitario: 22485],
        [articulo: 'LANIX 500  NEGRO ',   preciosub: 0, preciopub: 0, preciounitario: 0, totalarticulos: 0, costosub: 0, costopub: 0, costounitario: 0],
        [articulo: 'LG  165 BCO',   preciosub: 2138, preciopub: 2399, preciounitario: 2021, totalarticulos: 1, costosub: 2138, costopub: 2399, costounitario: 2399],
        [articulo: 'LG  220  DORADO ',   preciosub: 2178, preciopub: 2439, preciounitario: 2062, totalarticulos: 1, costosub: 2178, costopub: 2439, costounitario: 2439],
        [articulo: 'MOT 1032  NEGRO',   preciosub: 1289, preciopub: 1499, preciounitario: 1196, totalarticulos: 67, costosub: 86363, costopub: 100433, costounitario: 100433],
        [articulo: 'NANO CHIP',   preciosub: 80, preciopub: 150, preciounitario: 50, totalarticulos: 3, costosub: 240, costopub: 450, costounitario: 450],
        [articulo: 'NYX  JOIN BCO',   preciosub: 919, preciopub: 999, preciounitario: 825, totalarticulos: 1, costosub: 919, costopub: 999, costounitario: 999],
        [articulo: 'NYX  ZEUZ  ROSA ',   preciosub: 1389, preciopub: 1499, preciounitario: 1296, totalarticulos: 14, costosub: 19446, costopub: 20986, costounitario: 20986],
        [articulo: 'NYX MOBILE  FLY NEGRO',   preciosub: 1249, preciopub: 1499, preciounitario: 825, totalarticulos: 1, costosub: 1249, costopub: 1499, costounitario: 1499],
        [articulo: 'SAM  G355 BCO',   preciosub: 1859, preciopub: 1999, preciounitario: 1767, totalarticulos: 3, costosub: 5577, costopub: 5997, costounitario: 5997],
        [articulo: 'SAM  G355 NEGRO ',   preciosub: 1859, preciopub: 1999, preciounitario: 1767, totalarticulos: 1, costosub: 1859, costopub: 1999, costounitario: 1999],
        [articulo: 'SAM 7275  BCO',   preciosub: 1609, preciopub: 1749, preciounitario: 1517, totalarticulos: 13, costosub: 20917, costopub: 22737, costounitario: 22737],
        [articulo: 'SAM 7275  NEG ',   preciosub: 1609, preciopub: 1749, preciounitario: 1517, totalarticulos: 7, costosub: 11263, costopub: 12243, costounitario: 12243],
        [articulo: 'SAMSUNG 1205 G',   preciosub: 169, preciopub: 199, preciounitario: 0, totalarticulos: 1, costosub: 169, costopub: 199, costounitario: 199],
        [articulo: 'SAMSUNG 531  BCO',   preciosub: 2709, preciopub: 2999, preciounitario: 2593, totalarticulos: 1, costosub: 2709, costopub: 2999, costounitario: 2999],
        [articulo: 'SAMSUNG 531  DOR',   preciosub: 2709, preciopub: 2999, preciounitario: 2593, totalarticulos: 1, costosub: 2709, costopub: 2999, costounitario: 2999],
        [articulo: 'SENWA  301 BLANCO/AZUL',   preciosub: 275, preciopub: 299, preciounitario: 217, totalarticulos: 4, costosub: 1100, costopub: 1196, costounitario: 1196],
        [articulo: 'SENWA  301 BLANCO/ROJO ',   preciosub: 275, preciopub: 299, preciounitario: 217, totalarticulos: 8, costosub: 2200, costopub: 2392, costounitario: 2392],
        [articulo: 'SIM CARD',   preciosub: 50, preciopub: 70, preciounitario: 50, totalarticulos: 7, costosub: 350, costopub: 490, costounitario: 490],
        [articulo: 'SIM CARD  TRES',   preciosub: 80, preciopub: 150, preciounitario: 50, totalarticulos: 237, costosub: 18960, costopub: 35550, costounitario: 35550],
        [articulo: 'SIM CARD DIST',   preciosub: 150, preciopub: 199, preciounitario: 50, totalarticulos: 7, costosub: 1050, costopub: 1393, costounitario: 1393],
        [articulo: 'SIM CARD DIST TIP',   preciosub: 150, preciopub: 199, preciounitario: 50, totalarticulos: 10, costosub: 1500, costopub: 1990, costounitario: 1990],
        [articulo: 'SONY  2104 E4 BCO',   preciosub: 2288, preciopub: 2549, preciounitario: 2171, totalarticulos: 6, costosub: 13728, costopub: 15294, costounitario: 15294],
        [articulo: 'ZTE   460 BCO',   preciosub: 1859, preciopub: 1999, preciounitario: 1767, totalarticulos: 3, costosub: 5577, costopub: 5997, costounitario: 5997],
        [articulo: 'ZTE  L2  NEGRO',   preciosub: 1489, preciopub: 1599, preciounitario: 1369, totalarticulos: 23, costosub: 34247, costopub: 36777, costounitario: 36777],
        [articulo: 'ZTE 815 AZUL',   preciosub: 764, preciopub: 799, preciounitario: 682, totalarticulos: 1, costosub: 764, costopub: 799, costounitario: 799],
        [articulo: 'ZTE L2  PLUS BCO',   preciosub: 1577, preciopub: 1699, preciounitario: 1484, totalarticulos: 3, costosub: 4731, costopub: 5097, costounitario: 5097],
        [articulo: 'ZTE L2  PLUS DORADO',   preciosub: 1577, preciopub: 1699, preciounitario: 148, totalarticulos: 1, costosub: 1577, costopub: 1699, costounitario: 16994]
      ]

      tuplas.each { obj ->
        Inventario inv = new Inventario()
        inv.articulo = obj.articulo
        inv.precioSub = obj.preciosub
        inv.precioPublico = obj.preciopub
        inv.precioUnitario = obj.preciounitario
        inv.totalArticulos = obj.totalarticulos
        inv.costoSub = obj.costosub
        inv.costoPublico = obj.costopub
        inv.costoUnitario = obj.costounitario
        inv.usuarioCreacion = 'admin'
        inv.fechaCreacion = new Date()
        inv.save()
      }


    }

    def destroy = {
    }
}
