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

      def datos = params

      Inventario inv = new Inventario()
      inv.articulo = params.articulo
      inv.precioSub = 100
      inv.precioPublico = 100
      inv.precioUnitario = 100
      inv.totalArticulos = 0
      inv.costoSub = 100
      inv.costoPublico = 100
      inv.costoUnitario = 100
      inv.usuarioCreacion = 'admin'
      inv.fechaCreacion = new Date()
      inv.save()

      log.debug("Se guardo el articulo con id[" + inv.id + "]")

      redirect(action: 'index')
    }


}
