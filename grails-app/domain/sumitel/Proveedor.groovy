package sumitel

class Proveedor implements Serializable {

    String nombreProveedor
    boolean estatus

    Date fechaCreacion
    String usuarioCreacion
    Date fechaModificacion
    String usuarioModificacion

    static constraints = {
      fechaModificacion nullable: true
      usuarioModificacion nullable: true
    }

    static mapping = {
      table 'sumitel_proveedor'
      id column: 'id_proveedor'
    }

    String toString() {
      nombreProveedor
    }
}
