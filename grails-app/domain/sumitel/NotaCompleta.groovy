package sumitel

class NotaCompleta implements Serializable{

    String nombreCliente
    Long numeroRemision
    String nombreEquipo
    String direccionCliente
    String imei
    String simSerie
    Long telefono
    double precio
    double precioPublico
    String totalTexto
    Date fechaCreacion
    String usuarioCreacion
    Date fechaModificacion
    String usuarioModificacion


    static constraints = {
      fechaModificacion nullable: true
      usuarioModificacion nullable: true
    }

    static mapping = {
      table 'sumitel_nota_completa'
      id column: 'id_nota_completa'
      numeroRemision column: 'numero_remision', index: 'nota_numero_remision'
    }
}
