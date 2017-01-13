package sumitel

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

class ClienteController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Cliente.list(params), model:[clienteCount: Cliente.count()]
    }

    def show(Cliente cliente) {
        respond cliente
    }

    def create() {}

    @Transactional
    def save(Cliente cliente) {
        log.debug("en save: "+ cliente)
        log.debug("guardando un nuevo cliente")
        try {
            
          def datos = params
          Cliente c2 = new Cliente()
          c2.nombre = datos.nombre.toUpperCase()
          c2.ciudad = datos.ciudad.toUpperCase()
          c2.estado = datos.estado.toUpperCase()
          c2.fechaCreacion = new Date()
          c2.usuarioCreacion = 'admin'
          c2.save()


        } catch(Exception exc) {
            log.debug("no se pudo por: "+ exc)
        }

        

        redirect(controller: 'cliente', action: 'create')
    }


    def edit(Cliente cliente) {
        respond cliente
    }

    def guardarCliente =  {
        
        

    }

    @Transactional
    def update(Cliente cliente) {
        if (cliente == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (cliente.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond cliente.errors, view:'edit'
            return
        }

        cliente.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'cliente.label', default: 'Cliente'), cliente.id])
                redirect cliente
            }
            '*'{ respond cliente, [status: OK] }
        }
    }

    @Transactional
    def delete(Cliente cliente) {

        if (cliente == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        cliente.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'cliente.label', default: 'Cliente'), cliente.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'cliente.label', default: 'Cliente'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
