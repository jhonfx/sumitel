package sumitel

class OrdenCompra implements Serializable{

		Long numeroOrden
		Long numeroFactura
    int idCliente
    int idProveedor
		String nombreCliente
		String direccionCliente
    int cancelada
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
      totalCompra nullable:true
      direccionCliente nullable: true
      numeroOrden nullable: true
      numeroFactura nullable: true
      idCliente nullable: true
      idProveedor nullable: true
      nombreCliente nullable: true
      fechaCreacion nullable: true
      fechaModificacion nullable: true
    }

    static mapping = {
    	table 'sumitel_orden_compra'
    	id column: 'id_orden_compra'
    }
}
