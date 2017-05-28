package sumitel

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.converters.JSON

@Transactional(readOnly = true)
class UsuarioController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def loginUser() {

        def params = params
        def user = params.user
        def passw = params.passw

        log.debug(user)
        log.debug(passw)

        StringBuilder sql = new StringBuilder()
        sql.append("SELECT us from Usuario us where us.login = '${user}' and us.password = '${passw}'");
        log.debug(sql)
        def resultSQL = Usuario.executeQuery(sql.toString())
        log.debug(resultSQL.toString())
        def tuplasJson = []
        if (resultSQL == []) {
            //tuplasJson = [error: "No hay nada", code: 339]
            tuplasJson = [contentType: "text/json", status: 409]
        } else {
            tuplasJson = resultSQL.collect {
                tuplas : [
                    nombre: it.nombre,
                    apellido: it.apellido,
                    login: it.login,
                    session: true
                ]
            }
        }
        def jsonData = [response: tuplasJson]
        render jsonData as JSON
    }

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Usuario.list(params), model:[usuarioCount: Usuario.count()]
    }

    def show(Usuario usuario) {
        respond usuario
    }

    def create() {
        respond new Usuario(params)
    }

    @Transactional
    def save(Usuario usuario) {
        if (usuario == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (usuario.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond usuario.errors, view:'create'
            return
        }

        usuario.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'usuario.label', default: 'Usuario'), usuario.id])
                redirect usuario
            }
            '*' { respond usuario, [status: CREATED] }
        }
    }

    def edit(Usuario usuario) {
        respond usuario
    }

    @Transactional
    def update(Usuario usuario) {
        if (usuario == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (usuario.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond usuario.errors, view:'edit'
            return
        }

        usuario.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'usuario.label', default: 'Usuario'), usuario.id])
                redirect usuario
            }
            '*'{ respond usuario, [status: OK] }
        }
    }

    @Transactional
    def delete(Usuario usuario) {

        if (usuario == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        usuario.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'usuario.label', default: 'Usuario'), usuario.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'usuario.label', default: 'Usuario'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
