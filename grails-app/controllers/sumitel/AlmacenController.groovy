package sumitel

import grails.converters.JSON
import sumitel.Proveedor
import sumitel.Inventario
import sumitel.Almacen


class AlmacenController {
    
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() { }

    def altamasiva() { }

    def altaporpistola() { }

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

        //{"factura":"333341","precioUnitario":50,"precioPublico":150,"totalArticulos":16,"series":"091213487643878","articulo":"AMIGO CHIP  NANO LTE  SANTI","precioSub":115}

        try {
          tuplas_articulos.each{tupla->
            log.debug(tupla)
            Almacen obj = new Almacen()
            obj.fechaCompra = new Date()
            obj.numeroFactura = Long.parseLong(tupla.factura)
            obj.idProveedor = 1
            obj.proveedor = 'TELCEL'
            obj.idArticuloInventario = 1
            obj.articulo = tupla.articulo
            obj.imeiSim = tupla.series
            obj.costosub = tupla.precioSub * totalArticulo
            obj.precioPublico = tupla.precioPublico
            obj.costoUnitario = tupla.precioUnitario * totalArticulo
            obj.almacen = 'OF'
            obj.remision = '0'
            obj.fechaEntrega = new Date()
            obj.sub = 'NULL'
            obj.fechaCreacion = new Date()
            obj.usuarioCreacion = 'admin'
            obj.save(flush: true)
          
          }

          def productoInventario = Inventario.get(1)
          def sumArticulos = productoInventario.getTotalArticulos() + totalArticulo
          def newCostoSub = productoInventario.getPrecioSub() * totalArticulo
          def newCostoUnitario = productoInventario.getPrecioUnitario() * totalArticulo
          def newCostoPublico = productoInventario.getPrecioPublico() * totalArticulo

          productoInventario.setTotalArticulos(sumArticulos)
          productoInventario.setUsuarioModificacion('admin2')
          productoInventario.setfechaModificacion(new Date())
          productoInventario.setCostoSub(newCostoSub)
          productoInventario.setCostoUnitario(newCostoUnitario)
          productoInventario.setCostoPublico(newCostoPublico)
          productoInventario.save(flush: true)



        }
        catch(Exception e) {
          log.debug(e)
        }
        

        //render params as JSON
        log.debug("vamonos a la gsp ver articulos")
        //redirect(controller: 'almacen', action: 'listaAlmacen')
        def jsonResult = [success: true]
        render jsonResult as JSON
        
        
    }

    def obtenerAlmacen = {
      def almacenList = Almacen.findAll()
      log.debug(almacenList)
      def jsonData = [rows: almacenList]
      render jsonData as JSON
    }

    def listaAlmacen() {}

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
