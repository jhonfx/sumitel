package sumitel

class Almacen implements Serializable {

    String fechaCompra
    int numeroFactura
    int idProveedor
    int idArticuloInventario
    String imei
    String sim
    double costosub
    double precioPublico
    double costoUnitario
    String almacen
    String remision
    String fechaEntrega
    String sub
    Date   fechaCreacion
    String usuarioCreacion
    Date   fechaModificacion
    String usuarioModificacion

    static constraints = {
      numeroFactura maxSize: 10, nullable: false
      imei maxSize: 15, nullable: true
      sim maxSize: 20, nullable: true
      fechaModificacion nullable: true
      usuarioModificacion nullable: true
    }

    static mapping = {
      table 'sumitel_almacen'
      id column: 'id_almacen'
    }
}
