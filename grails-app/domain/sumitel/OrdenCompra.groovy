package sumitel

class OrdenCompra implements Serializable{

		Long numeroOrden
		Long numeroFactura
		String nombreCliente
		String direccionCliente


		Date fechaCreacion
		String usuarioCreacion
		Date fechaModificacion
		String usuarioModificacion

    static constraints = {
    	fechaModificacion nullable: true
      usuarioModificacion nullable: true
    }

    static mapping = {
    	table 'sumitel_orden_compra'
    	id column: 'id_orden_compra'
    }
}
