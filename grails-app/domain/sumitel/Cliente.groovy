package sumitel

class Cliente implements Serializable {

		String nombre
		String ciudad
		String estado

		Date fechaCreacion
		String usuarioCreacion
		Date fechaModificacion
		String usuarioModificacion



    static constraints = {
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
