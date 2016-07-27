package sumitel

import grails.converters.JSON
import sumitel.Proveedor
import sumitel.Inventario
import sumitel.Almacen


class AlmacenController {
    
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() { }

    def altamasiva() { }

    def listaInventario () {
      def inventario = Inventario.findAll()
      return [inventario: inventario]
    }

    def listaProveedor() {
      def proveedor = Proveedor.findAll()
      return [proveedor: proveedor]

    }

    def saveData = {

        log.debug("ya debuggea???")
        log.debug(params);

        def tuplas_articulos = JSON.parse(params.tuplas)
        log.debug "Total de tuplas a guardar" + tuplas_articulos.size()
        def totalArticulo = tuplas_articulos.size();

        try {
          tuplas_articulos.each{tupla->
            log.debug(tupla)
            /*Almacen obj = new Almacen()
            obj.fechaCompra = new Date()
            obj.numeroFactura = Integer.parseInt(tupla.factura)
            obj.idProveedor = 1
            obj.idArticuloInventario = 1
            obj.imei = tupla.series
            obj.sim = 'NO TIENE'
            obj.costosub = tupla.precioSub * totalArticulo
            obj.precioPublico = tupla.precioPublico
            obj.costoUnitario = tupla.precioUnitario * totalArticulo
            obj.almacen = 'OF'
            obj.remision = '88859092'
            obj.fechaEntrega = new Date()
            obj.sub = 'NULL'
            obj.fechaCreacion = new Date()
            obj.usuarioCreacion = 'admin'
            obj.save()*/
          
          }

          /*def productoInventario = Inventario.findAllById(1)
          log.debug(productoInventario.totalArticulos);
          productoInventario.totalArticulos = productoInventario.totalArticulos + totalArticulo
          productoInventario.save(flush: true)*/

        }
        catch(Exception e) {
          log.debug(e)
        }
        

        //render params as JSON
        log.debug("vamonos a la gsp ver articulos")
        redirect(controller: 'almacen', action: 'listaalmacen')
        
    }

    def listaalmacen = {}

    def obtenerArticulos = {
        StringBuilder sql = new StringBuilder()
        sql.append(" SELECT alm from Almacen alm");
        log.debug(sql)
        def resultSQL = Almacen.executeQuery(sql.toString())
        log.debug(resultSQL.toString())

        def tuplasJson = resultSQL.collect {
          tuplas: [
            factura: it.factura,
            serie: it.serie,
            descripcion: it.descripcion
          ]
        }
        log.debug(tuplasJson)
        def jsonData = [rows: tuplasJson]
        render jsonData as JSON
    }
}
