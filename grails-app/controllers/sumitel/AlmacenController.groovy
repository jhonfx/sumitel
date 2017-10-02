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


        def tuplas_articulos = JSON.parse(params.tuplas)
        def totalArticulo = tuplas_articulos.size();
        def idProd = tuplas_articulos.idProducto
        def cant = tuplas_articulos.cant
        def searchFact = Almacen.findByNumeroFactura(params.factura)
        try {
            if (searchFact) {
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
      def jsonData = [rows: almacenList]
      render jsonData as JSON
    }

    def obtenerAlmacen2 = {
      def almacenList = Almacen.findAll(" from Almacen as alm where alm.remision = 0")
      def jsonData = [rows: almacenList]
      render jsonData as JSON
    }

    def deleteProducto = {
      def params = params
      def id = params.id
      def idArt = params.idArticulo

      StringBuilder sql = new StringBuilder()
      sql.append("DELETE from Almacen alm where alm.id = ${id}")
      def resultSQL = Almacen.executeUpdate(sql.toString())

      def invAlm = Inventario.get(idArt)
      def totalAlm = invAlm.getTotalArticulos()
      def resta = totalAlm - 1
      def mod_costoSub = (resta*invAlm.getPrecioSub())
      def mod_costoUni = (resta*invAlm.getPrecioUnitario())
      def mod_costoPub = (resta*invAlm.getPrecioPublico())
      

      StringBuilder update_cant_art = new StringBuilder()
      update_cant_art.append("UPDATE Inventario inv set inv.totalArticulos = ${resta}, inv.costoSub = ${mod_costoSub}, inv.costoUnitario = ${mod_costoUni}, inv.costoPublico = ${mod_costoPub} where inv.id = ${idArt}");
      def resultSQL_update = Almacen.executeUpdate(update_cant_art.toString())

      def jsonResult = [success: true]
      render(jsonResult as JSON)
    }

    def listaalmacen() {}

    def listaparaorden() {}

    def obtenerArticulosDos = {
        StringBuilder sql = new StringBuilder()
        sql.append(" SELECT alm from Almacen alm where alm.remision = 0 and alm.articulo like '%SIM%'");
        def resultSQL = Almacen.executeQuery(sql.toString())
        
        def tuplasJson = resultSQL.collect {
          tuplas: [
            id: it.id, 
            almacen: it.almacen,
            articulo: it.articulo,
            imeiSim: it.imeiSim,
            precioPublico: it.precioPublico,
            precioUnitario: it.precioUnitario,
            proveedor: it.proveedor,
            factura: it.numeroFactura
          ]
        }
        
        def jsonData = [rows: tuplasJson]
        render jsonData as JSON
    }

    def obtenerArticulos = {
        StringBuilder sql = new StringBuilder()
        sql.append(" SELECT alm from Almacen alm");
        def resultSQL = Almacen.executeQuery(sql.toString())
      
        def tuplasJson = resultSQL.collect {
          tuplas: [
            factura: it.factura,
            serie: it.serie,
            descripcion: it.descripcion
          ]
        }
        def jsonData = [rows: tuplasJson]
        render jsonData as JSON
    }

    def cancelarOrdenCompra = {
       
        def totalPrice = 0

        def grupoAlmacen = Almacen.findAllByRemision(params.id)
        
        OrdenCompra occ = OrdenCompra.findByNumeroOrden(params.id);
        occ.cancelada = 1
        occ.save()


        def clienteid = params.idcliente
        grupoAlmacen.each {tuplas->

            def art_inventario = Inventario.get(tuplas.idArticuloInventario)
            
            def total = art_inventario.getTotalArticulos()
            
            totalPrice = totalPrice + tuplas.precioUnitario
            
            art_inventario.setTotalArticulos(total + 1)
            art_inventario.setCostoPublico(art_inventario.getPrecioPublico() * art_inventario.getTotalArticulos())
            art_inventario.setCostoUnitario(art_inventario.getPrecioUnitario() * art_inventario.getTotalArticulos())
            art_inventario.setCostoSub(art_inventario.getPrecioSub() * art_inventario.getTotalArticulos())

            tuplas.remision = 0

        }

        Cliente cc = Cliente.get(clienteid)
        
        def restSaldo = cc.getSaldoTotal() - totalPrice
        cc.setSaldoTotal(restSaldo)
        cc.save()
      
        def tuplasJson = grupoAlmacen.collect {
          tuplas: [
            factura: 0,
            serie: 0,
            descripcion: 0
          ]
        }
        def jsonData = [rows: tuplasJson]
        render jsonData as JSON
    }
}
