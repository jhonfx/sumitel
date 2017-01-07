package sumitel

class Almacen implements Serializable {

    Date fechaCompra
    Long numeroFactura
    int idProveedor
    String proveedor
    int idArticuloInventario
    String articulo
    String imeiSim
    String imeiCel
    String numeroCel = "00000"
    double costoSub
    double precioPublico
    double precioUnitario
    double costoUnitario
    String almacen
    String remision
    Date fechaEntrega
    String sub
    Date   fechaCreacion 
    String usuarioCreacion
    Date   fechaModificacion
    String usuarioModificacion

    static constraints = {
      numeroFactura maxSize: 10, nullable: false
      imeiSim maxSize: 20, nullable: true
      fechaModificacion nullable: true
      usuarioModificacion nullable: true
    }

    static mapping = {
      table 'sumitel_almacen'
      id column: 'id_almacen'
    }
}
