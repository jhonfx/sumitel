package sumitel

import grails.converters.JSON

class InventarioController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() { }

    def listarArticulos = {  }

    def updateCancelArticle() {
      log.debug("params----->" + params)

      def article_= Inventario.get(params.id);
      log.debug(article_)
      def estatus = article_.getActivo();
      log.debug(estatus)

      if (estatus == true) {
        article_.setActivo(false)
      } else {
        article_.setActivo(true)
      }
      
      article_.save(flush: true)

      render article_ as JSON
    }

    def obtenerListaArticulos = {

      StringBuilder sql = new StringBuilder()
      sql.append("Select inv from Inventario inv order by inv.id DESC");
      def resultSQL = Inventario.executeQuery(sql.toString())
      log.debug(resultSQL.toString())

      def tuplasJSON = resultSQL.collect {
        tuplas: [
          id: it.id,
          articulo: it.articulo,
          activo: it.activo,
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

    

    def editArticle() {
      def params = params
      def art = params.art.toUpperCase()
      def pp = Double.parseDouble(params.pp)
      def pu = Double.parseDouble(params.pu)
      def ps = Double.parseDouble(params.ps)
      def id = params.id


      def article_ = Inventario.get(id);
      def total = article_.totalArticulos;

      article_.setArticulo(art)
      article_.setPrecioPublico(pp)
      article_.setPrecioUnitario(pu)
      article_.setPrecioSub(ps)
      article_.setCostoPublico(total * pp)
      article_.setCostoUnitario(total * pu)
      article_.setCostoSub(total * ps)
      article_.save(flush: true);

      log.debug("id_articulo>>>>>>>" + id)
      StringBuilder sql = new StringBuilder()
      sql.append("UPDATE Almacen alm set alm.articulo = '${art}', alm.precioPublico = ${pp}, alm.precioUnitario = '${pu}' where alm.idArticuloInventario = ${id}");
      log.debug(sql.toString());
      def resultSQL = Almacen.executeUpdate(sql.toString())
      log.debug("resultQuery=>>>>" + resultSQL)
      log.debug("termina proceso SQL____>>>>>>>>")
      
      /*StringBuilder sql = new StringBuilder()
      sql.append("UPDATE Inventario inv set inv.precioPublico = ${pp}, inv.precioSub = '${ps}', inv.precioUnitario = '${pu}' where inv.id = ${params.fact}");
      log.debug(sql.toString());
      def resultSQL = Almacen.executeUpdate(sql.toString())
      log.debug("resultQuery=>>>>" + resultSQL)*/

      render article_ as JSON
    }

    def searchByArticle() {
      def id = params.id
      log.debug(id)
      def article_ = Inventario.findAllById(id)
      render article_ as JSON
    }


    def saveArticle() {

      
      log.debug("guardando los datos de nuevo articulo.........]" + params)
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
      inv.tipoArticulo = datos.tipo
      inv.activo = 1
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
