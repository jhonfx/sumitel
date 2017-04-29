package sumitel

class Articulo implements Serializable{

    String articulo
    Double precioSub
    Double precioPublico
    Double precioUnitario
    String usuarioCreacion
    boolean estatus = 0;
    Date fechaCreacion
    String usuarioModificacion
    Date fechaModificacion

    static mapping = {
      table 'sumitel_articulo'
      id colum: 'id_articulo'
    }

    static constraints = {
      estatus nullable: true, display: false
      fechaModificacion nullable: true, display: false
      usuarioModificacion nullable: true, display: false
    }

    String toString() {
      articulo
    }
}
