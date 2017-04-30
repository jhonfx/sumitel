package sumitel

class Articulo implements Serializable{

    String articulo
    Double precioSub
    Double precioPublico
    Double precioUnitario
    String usuarioCreacion
    Date fechaCreacion
    String usuarioModificacion
    Date fechaModificacion

    static mapping = {
      table 'sumitel_articulo'
      id colum: 'id_articulo'
    }

    static constraints = {
      fechaModificacion nullable: true, display: false
      usuarioModificacion nullable: true, display: false
    }

    String toString() {
      articulo
    }
}
