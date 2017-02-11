package sumitel

import grails.converters.JSON
import grails.transaction.Transactional
import sumitel.CantidadesEnLetraUtils


class OrdenCompraController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def buscarfact() { }

    def printOrden() { 
        log.debug(params)
    }

    def printOrdenCompleta() {

    }

    def datosPrintOrdenCompleta() {
        log.debug("datosPrintOrden" + params)

        def notaCompleta = NotaCompleta.findAll("from NotaCompleta as nc where nc.numeroRemision = ${params.remision}")
        log.debug(notaCompleta)
        render notaCompleta as JSON
    }
 
    def datosPrintOrden() {
        log.debug("datosPrintOrden" + params)
        StringBuilder sql = new StringBuilder()
        //sql.append("Select alm from Almacen alm where alm.numeroFactura = ${params.fact}");
        sql.append("SELECT count(*) as total, alm.articulo, alm.precioPublico, alm.imeiSim, alm.imeiCel, alm.precioUnitario, alm.idArticuloInventario from Almacen alm where alm.numeroFactura = ${params.fact}  group by alm.articulo")
        def resultSQL = Inventario.executeQuery(sql.toString())
        log.debug("###este es del datosPrintOrden####  " + resultSQL);

        StringBuilder sql_select = new StringBuilder()
        sql_select.append("Select oc from OrdenCompra oc where oc.numeroFactura = ${params.fact}")
        log.debug(sql_select.toString())
        def resultSQL_oc = OrdenCompra.executeQuery(sql_select.toString())
        log.debug("resultSQL=>>>>"+ resultSQL_oc)
        def remision = resultSQL_oc

        def tuplasJSON = resultSQL.collect {
            tuplas: [
                total: it[0],
                articulo: it[1],
                precioPublico: it[2],
                imeisim: it[3],
                imeicel: it[4],
                precioUnitario: it[5],
                coste: it[0] * it[5],
                idArticulo: it[6]
            ]
        }

        def infoOrden =  resultSQL_oc.collect {
            tuplas: [
                numOrden: it.numeroOrden,
                nombre: it.nombreCliente,
                direccion: it.direccionCliente
            ] 
        }

        def jsonData = [rows: tuplasJSON, info: infoOrden]
        render jsonData as JSON
    }

    def searchFactura = {

        log.debug(params)

        StringBuilder sql = new StringBuilder()
        sql.append("Select alm from Almacen alm where alm.numeroFactura = ${params.fact}");
        def resultSQL = Almacen.executeQuery(sql.toString())
        log.debug(resultSQL)


        def tuplasJSON = resultSQL.collect {
            tuplas: [
                fechaCompra: it.fechaCompra,
                articulo: it.articulo,
                imeisim: it.imeiSim,
                imeicel: it.imeiCel,
                precioPublico: it.precioPublico,
                almacen: it.almacen,
                idArticulo: it.idArticuloInventario
            ]
        }

        def jsonData = [rows: tuplasJSON]
        render jsonData as JSON
    }

    def searchClientInfo = {
        def client = Cliente.findAllById(params.id)
        log.debug(client)
        render client as JSON
    }

    def generarOrden = {
        log.debug("params: " + params)
        def datos = params


        StringBuilder sql_select = new StringBuilder()
        sql_select.append("Select oc.numeroOrden from OrdenCompra oc order by oc.numeroOrden DESC")
        log.debug(sql_select.toString())
        def resultSQL_oc = OrdenCompra.executeQuery(sql_select.toString(), [max: 1])
        log.debug("resultSQL=>>>>"+ resultSQL_oc[0])
        def remision = resultSQL_oc[0]

        OrdenCompra oc = new OrdenCompra()
        oc.numeroFactura = Long.parseLong(params.fact)
        oc.numeroOrden = remision + 1
        oc.nombreCliente = params.name
        oc.direccionCliente = params.ciudad +', '+ params.estado
        oc.fechaCreacion = new Date()
        oc.usuarioCreacion = 'admin'
        oc.fechaModificacion = new Date()
        oc.usuarioModificacion = 'admin'
        oc.save()

        StringBuilder sql = new StringBuilder()
        sql.append("UPDATE Almacen alm set alm.remision = ${remision}, alm.almacen = '${params.name}' where alm.numeroFactura = ${params.fact}");
        log.debug(sql.toString());
        def resultSQL = Almacen.executeUpdate(sql.toString())
        log.debug("resultQuery=>>>>" + resultSQL)

        StringBuilder idarticulos = new StringBuilder()
        idarticulos.append("SELECT count(*) as total, alm.idArticuloInventario from Almacen alm where alm.numeroFactura = ${params.fact} group by alm.articulo");
        log.debug(idarticulos.toString());
        def resultSQL_articulos = Almacen.executeQuery(idarticulos.toString())
        log.debug("resultQuery=>>>>" + resultSQL_articulos)

        resultSQL_articulos.each{tupla->
            def prodInv = Inventario.get(tupla[1])
            log.debug(prodInv)
            def idart = tupla[1];
            def totalActual = prodInv.getTotalArticulos()
            log.debug(totalActual);
            log.debug("le vamos a quitar: " + tupla[0]);
            def resta = totalActual - tupla[0]
            log.debug(resta);

            StringBuilder update_cant_art = new StringBuilder()
            update_cant_art.append("UPDATE Inventario inv set inv.totalArticulos = ${resta} where inv.id = ${idart}");
            log.debug(update_cant_art.toString());
            def resultSQL_update = Almacen.executeUpdate(update_cant_art.toString())
            log.debug("resultQuery=>>>>" + resultSQL_update)

            //prodInv.setTotalArticulos(totalActual - tupla[0])
            //prodInv.update(flush: true)
        }

        //log.debug("Se guardo el articulo con id [" + oc.id + "]")
        def jsonResult = [success: true, factura: params.fact]
        render(jsonResult as JSON)
    }


     def generarOrdenCompleta = {
        log.debug("params: " + params)
        def datos = params
        def tuplas_art = JSON.parse(datos.obj)
        def list = new ArrayList()
        def lista_id = JSON.parse(params.ids)
        lista_id.each{i->
            log.debug(i.id)
            list.add(i.id)
        }
        log.debug(list)
        
        StringBuilder sql_select = new StringBuilder()
        sql_select.append("Select nt.numeroRemision from NotaCompleta nt order by nt.numeroRemision DESC")
        log.debug(sql_select.toString())
        def resultSQL_oc = OrdenCompra.executeQuery(sql_select.toString(), [max: 1])
        log.debug("resultSQL=>>>>"+ resultSQL_oc[0])
        def remision = resultSQL_oc[0]


        OrdenCompra oc = new OrdenCompra()
        oc.numeroFactura = Long.parseLong("0")
        oc.numeroOrden = remision + 1
        oc.nombreCliente = params.name
        oc.direccionCliente = params.ciudad +', '+ params.estado
        oc.fechaCreacion = new Date()
        oc.usuarioCreacion = 'admin'
        oc.fechaModificacion = new Date()
        oc.usuarioModificacion = 'admin'
        oc.save()

        

        def nextRemision = remision + 1
        def totalCompra = 0

        try {
            tuplas_art.each{tupla->
                

                totalCompra = tupla.preciopublico + totalCompra
                NotaCompleta nc = new NotaCompleta()
                nc.setNombreCliente(params.name)
                nc.setNumeroRemision(nextRemision)
                nc.setNombreEquipo(tupla.article)
                nc.setDireccionCliente(params.ciudad +',  '+ params.estado)
                nc.setImei(tupla.imei)
                nc.setSimSerie(tupla.seriesim)
                nc.setPrecio(tupla.preciounitario)
                nc.setPrecioPublico(tupla.preciopublico)
                nc.setTelefono(0)
                nc.setTotalTexto(CantidadesEnLetraUtils.convertNumberToLetter(totalCompra, 'PESOS', true))
                nc.setFechaCreacion(new Date())
                nc.setUsuarioCreacion("admin")
                nc.save(flush: true)
                log.debug(nc)
            }

        } catch(Exception exec) {
            log.debug(exec)
        }
        
        

        lista_id.each{i->
            StringBuilder sql = new StringBuilder()
            sql.append("UPDATE Almacen alm set alm.remision = ${nextRemision}, alm.almacen = '${params.name}' where alm.id = ${i.id}");
            log.debug(sql.toString())
            def resultSQL = Almacen.executeUpdate(sql.toString())
            log.debug("resultQuery=>>>>" + resultSQL)    
        }
        
        

        StringBuilder idarticulos = new StringBuilder()
        idarticulos.append("SELECT count(*) as total, alm.idArticuloInventario from Almacen alm where alm.remision = ${nextRemision} group by alm.articulo");
        log.debug(idarticulos.toString());
        def resultSQL_articulos = Almacen.executeQuery(idarticulos.toString())
        log.debug("resultQuery=>>>>" + resultSQL_articulos)

        resultSQL_articulos.each{tupla->
            def prodInv = Inventario.get(tupla[1])
            log.debug(prodInv)
            def idart = tupla[1];
            def totalActual = prodInv.getTotalArticulos()
            log.debug(totalActual);
            log.debug("le vamos a quitar: " + tupla[0]);
            def resta = totalActual - tupla[0]
            log.debug(resta);

            StringBuilder update_cant_art = new StringBuilder()
            update_cant_art.append("UPDATE Inventario inv set inv.totalArticulos = ${resta} where inv.id = ${idart}");
            log.debug(update_cant_art.toString());
            def resultSQL_update = Almacen.executeUpdate(update_cant_art.toString())
            log.debug("resultQuery=>>>>" + resultSQL_update)
        }

        def jsonResult = [success: true, remision: nextRemision, totalTexto: totalCompra]
        render(jsonResult as JSON)
    }
    

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond OrdenCompra.list(params), model:[ordenCompraCount: OrdenCompra.count()]
    }

    def show(OrdenCompra ordenCompra) {
        respond ordenCompra
    }

    def create() {
        respond new OrdenCompra(params)
    }

    @Transactional
    def save(OrdenCompra ordenCompra) {
        if (ordenCompra == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (ordenCompra.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond ordenCompra.errors, view:'create'
            return
        }

        ordenCompra.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'ordenCompra.label', default: 'OrdenCompra'), ordenCompra.id])
                redirect ordenCompra
            }
            '*' { respond ordenCompra, [status: CREATED] }
        }
    }

    def edit(OrdenCompra ordenCompra) {
        respond ordenCompra
    }

    @Transactional
    def update(OrdenCompra ordenCompra) {
        if (ordenCompra == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (ordenCompra.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond ordenCompra.errors, view:'edit'
            return
        }

        ordenCompra.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ordenCompra.label', default: 'OrdenCompra'), ordenCompra.id])
                redirect ordenCompra
            }
            '*'{ respond ordenCompra, [status: OK] }
        }
    }

    @Transactional
    def delete(OrdenCompra ordenCompra) {

        if (ordenCompra == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        ordenCompra.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ordenCompra.label', default: 'OrdenCompra'), ordenCompra.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'ordenCompra.label', default: 'OrdenCompra'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
