package sumitel

class AbonoCliente implements Serializable {

    Double AbonoCliente
    Long idCliente

    Date fechaCreacion
    String usuarioCreacion
    Date fechaModificacion
    String usuarioModificacion

    static constraints = {
      fechaModificacion nullable: true
      usuarioModificacion nullable: true
    }

    static mapping = {
      table 'sumitel_abono_cliente'
      id column: 'id_abono'
    }
}
