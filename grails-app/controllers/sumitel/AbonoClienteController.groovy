package sumitel

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AbonoClienteController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AbonoCliente.list(params), model:[abonoClienteCount: AbonoCliente.count()]
    }

    def show(AbonoCliente abonoCliente) {
        respond abonoCliente
    }

    def create() {
        respond new AbonoCliente(params)
    }

    @Transactional
    def save(AbonoCliente abonoCliente) {
        if (abonoCliente == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (abonoCliente.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond abonoCliente.errors, view:'create'
            return
        }

        abonoCliente.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'abonoCliente.label', default: 'AbonoCliente'), abonoCliente.id])
                redirect abonoCliente
            }
            '*' { respond abonoCliente, [status: CREATED] }
        }
    }

    def edit(AbonoCliente abonoCliente) {
        respond abonoCliente
    }

    @Transactional
    def update(AbonoCliente abonoCliente) {
        if (abonoCliente == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (abonoCliente.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond abonoCliente.errors, view:'edit'
            return
        }

        abonoCliente.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'abonoCliente.label', default: 'AbonoCliente'), abonoCliente.id])
                redirect abonoCliente
            }
            '*'{ respond abonoCliente, [status: OK] }
        }
    }

    @Transactional
    def delete(AbonoCliente abonoCliente) {

        if (abonoCliente == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        abonoCliente.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'abonoCliente.label', default: 'AbonoCliente'), abonoCliente.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'abonoCliente.label', default: 'AbonoCliente'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
