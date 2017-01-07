package sumitel

class Inventario implements Serializable {

    String articulo
    Double precioSub
    Double precioPublico
    Double precioUnitario
    int totalArticulos
    Double costoSub
    Double costoUnitario
    Double costoPublico
    String tipoArticulo

    boolean activo
    String usuarioCreacion
    Date fechaCreacion
    String usuarioModificacion
    Date fechaModificacion


    static mapping = {
      table 'sumitel_inventario'
      id colum: 'id_inventario'
    }

    static constraints = {
      precioSub nullable: true
      precioPublico nullable: true
      precioUnitario nullable: true
      fechaModificacion nullable: true, display: false
      usuarioModificacion nullable: true, display: false
    }

    String toString() {
      articulo
    }

}
