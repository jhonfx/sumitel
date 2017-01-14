package sumitel

import grails.converters.JSON

class AlmacenController {
    
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() { }

    def altamasiva() { }

    def altaporpistola() { }

    def mandameaOtraWEb() {
      log.debug("vamonos a la gsp ver articulos")
      redirect(controller: 'inventario', action: 'listarArticulos')
    }


    def listaInventario () {
      def inventario = Inventario.findAll()
      return [inventario: inventario]
    }

    def listaProveedor() {
      def proveedor = Proveedor.findAll()
      return [proveedor: proveedor]

    }

    def checkFactura = {
        
    }

    def saveData = {

        log.debug("ya debuggea???")
        log.debug(params);

        def tuplas_articulos = JSON.parse(params.tuplas)
        log.debug "Total de tuplas a guardar: " + tuplas_articulos.size()
        def totalArticulo = tuplas_articulos.size();
        def idProd = tuplas_articulos.idProducto
        log.debug(idProd)
        def cant = tuplas_articulos.cant

        log.debug(params)
        log.debug(params.factura)
        def searchFact = Almacen.findByNumeroFactura(params.factura)
        log.debug("factura----->" + searchFact);
        log.debug("buscando factura");
        try {
            if (searchFact) {
                 log.debug("factura ya existe");
                 def jsonResult = [error: 303]
                 render jsonResult as JSON
                 return
            }    
        } catch(Exception exec) {
            log.debug(exec)
        }
         
        //{"factura":"333341","precioUnitario":50,"precioPublico":150,"totalArticulos":16,"series":"091213487643878","articulo":"AMIGO CHIP  NANO LTE  SANTI","precioSub":115}
        def count = 0;
        try {

          tuplas_articulos.each{tupla->
            
            Almacen obj = new Almacen()
            obj.fechaCompra = new Date()
            obj.numeroFactura = Long.parseLong(tupla.factura)
            obj.idProveedor = 1
            obj.proveedor = 'TELCEL'
            obj.idArticuloInventario = tupla.idProducto
            obj.articulo = tupla.articulo
            obj.imeiSim = tupla.series
            obj.imeiCel = tupla.imeiCel
            obj.numeroCel = tupla.numeroCel
            obj.costoSub = tupla.precioSub * totalArticulo
            obj.precioPublico = tupla.precioPublico
            obj.precioUnitario = tupla.precioUnitario
            obj.costoUnitario = tupla.precioUnitario * totalArticulo
            obj.almacen = 'OF'
            obj.remision = '0'
            obj.fechaEntrega = new Date()
            obj.sub = 'NULL'
            obj.fechaCreacion = new Date()
            obj.usuarioCreacion = 'admin'
            obj.save(flush: true)
          
          }

          idProd.eachWithIndex{id, index->
            log.debug("id: "+ id)

            def productoInventario = Inventario.get(id)
            def sumArticulos = productoInventario.getTotalArticulos() + 1
            def newCostoSub = productoInventario.getPrecioSub() * sumArticulos
            def newCostoUnitario = productoInventario.getPrecioUnitario() * sumArticulos
            def newCostoPublico = productoInventario.getPrecioPublico() * sumArticulos
            

            productoInventario.setTotalArticulos(sumArticulos)
            productoInventario.setUsuarioModificacion('admin2')
            productoInventario.setFechaModificacion(new Date())
            productoInventario.setCostoSub(newCostoSub)
            productoInventario.setCostoUnitario(newCostoUnitario)
            productoInventario.setCostoPublico(newCostoPublico)
            productoInventario.save(flush: true)

          }



        }
        catch(Exception e) {
          log.debug(e)
        }

        def jsonResult = [success: true]
        render(jsonResult as JSON)
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
