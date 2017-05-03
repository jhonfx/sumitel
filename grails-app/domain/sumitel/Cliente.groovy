package sumitel

class Cliente implements Serializable {

		String nombre
		String ciudad
		String estado
        Double saldoTotal = 0
        Double abonoSaldo = 0
        boolean estatus

		Date fechaCreacion
		String usuarioCreacion
		Date fechaModificacion
		String usuarioModificacion



    static constraints = {
        saldoTotal nullable: true
        abonoSaldo nullable: true
        estatus nullable: true
    	fechaModificacion nullable: true
    	usuarioModificacion nullable: true

    }

    static mapping = {
    	table 'sumitel_clientes'
    	id column: 'id_cliente'
    }

    String toString() {
    	nombre
    }
}
