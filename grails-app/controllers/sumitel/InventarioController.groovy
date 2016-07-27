package sumitel

import grails.converters.JSON

class InventarioController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() { }

    def listarArticulos = {  }

    def obtenerListaArticulos = {

      StringBuilder sql = new StringBuilder()
      sql.append("Select inv from Inventario inv");
      def resultSQL = Inventario.executeQuery(sql.toString())
      log.debug(resultSQL.toString())

      def tuplasJSON = resultSQL.collect {
        tuplas: [
          articulo: it.articulo,
          precioSub: it.precioSub,
          precioPublico: it.precioPublico,
          precioUnitario: it.precioUnitario,
          totalArticulos: it.totalArticulos,
          costoSub: it.costoSub,
          costoPublico: it.costoPublico,
          costoUnitario: it.costoUnitario,
          usuarioCreacion: it.usuarioCreacion,
          fechaCreacion: it.fechaCreacion
        ]
      }

      def jsonData = [rows: tuplasJSON]
      render jsonData as JSON

    }

    def create = {}

    def saveArticle() {

      
      log.debug("guardando los datos.........]")
      def datos = params
      def formatCostoSub = params.costoSub.replace(',', '')
      def formatCostoPublico = params.costoPublico.replace(',', '')
      def formatCostoUnitario = params.costoUnitario.replace(',', '')

      Inventario inv = new Inventario()
      inv.articulo = params.articulo.toUpperCase()
      inv.precioSub = Double.parseDouble(formatCostoSub)
      inv.precioPublico = Double.parseDouble(formatCostoPublico)
      inv.precioUnitario = Double.parseDouble(formatCostoUnitario)
      inv.totalArticulos = 0
      inv.costoSub = Double.parseDouble(formatCostoSub)
      inv.costoPublico = Double.parseDouble(formatCostoPublico)
      inv.costoUnitario = Double.parseDouble(formatCostoUnitario)
      inv.usuarioCreacion = 'admin'
      inv.fechaCreacion = new Date()
      inv.save()

      log.debug("Se guardo el articulo con id[" + inv.id + "]")

      redirect(controller: 'inventario', action: 'listarArticulos')
    }

    def infoProducto = {

      def producto = Inventario.findAllById(params.id)
      log.debug(producto)
      render producto as JSON

    }

}
