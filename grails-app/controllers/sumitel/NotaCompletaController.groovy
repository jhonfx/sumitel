package sumitel

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class NotaCompletaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond NotaCompleta.list(params), model:[notaCompletaCount: NotaCompleta.count()]
    }

    def show(NotaCompleta notaCompleta) {
        respond notaCompleta
    }

    def create() {
        respond new NotaCompleta(params)
    }

    @Transactional
    def save(NotaCompleta notaCompleta) {
        if (notaCompleta == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (notaCompleta.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond notaCompleta.errors, view:'create'
            return
        }

        notaCompleta.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'notaCompleta.label', default: 'NotaCompleta'), notaCompleta.id])
                redirect notaCompleta
            }
            '*' { respond notaCompleta, [status: CREATED] }
        }
    }

    def edit(NotaCompleta notaCompleta) {
        respond notaCompleta
    }

    @Transactional
    def update(NotaCompleta notaCompleta) {
        if (notaCompleta == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (notaCompleta.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond notaCompleta.errors, view:'edit'
            return
        }

        notaCompleta.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'notaCompleta.label', default: 'NotaCompleta'), notaCompleta.id])
                redirect notaCompleta
            }
            '*'{ respond notaCompleta, [status: OK] }
        }
    }

    @Transactional
    def delete(NotaCompleta notaCompleta) {

        if (notaCompleta == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        notaCompleta.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'notaCompleta.label', default: 'NotaCompleta'), notaCompleta.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'notaCompleta.label', default: 'NotaCompleta'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
