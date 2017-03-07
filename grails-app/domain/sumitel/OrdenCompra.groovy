package sumitel

class OrdenCompra implements Serializable{

		Long numeroOrden
		Long numeroFactura
        Long idCliente
        Long idProveedor
		String nombreCliente
		String direccionCliente
        int cancelada = 1
        double totalCompra
		Date fechaCreacion
		String usuarioCreacion
		Date fechaModificacion
		String usuarioModificacion

    static constraints = {
      fechaModificacion nullable: true
      usuarioModificacion nullable: true
      idCliente nullable: true
      idProveedor nullable: true
      cancelada nullable: true
    }

    static mapping = {
    	table 'sumitel_orden_compra'
    	id column: 'id_orden_compra'
    }
}
