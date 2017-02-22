import sumitel.Menu
import sumitel.Proveedor
import sumitel.Usuario
import sumitel.OrdenCompra
import sumitel.NotaCompleta

class BootStrap {

    def init = { servletContext ->

      /*Proveedor prov = new Proveedor()
      prov.nombreProveedor = 'TELCEL'
      prov.estatus = 1
      prov.usuarioCreacion = 'admin'
      prov.fechaCreacion = new Date()
      prov.save()


      def menuList = ['Compras', 'Clientes', 'Usuarios', 'Almacen', 'Inventario', 'Orden Compra', 'Notas Devolucion']
      menuList.each { obj -> 
        Menu menu = new Menu()
        menu.descripcionMenu = obj
        menu.save() 
      }

      Usuario u = new Usuario()
      u.nombre = 'Juan'
      u.apellido = 'Purata'
      u.login = 'admin'
      u.password = 'admin'
      u.usuarioCreacion = 'admin'
      u.fechaCreacion = new Date()
      u.save()

      OrdenCompra oc = new OrdenCompra()
      
      oc.numeroOrden = 23460
      oc.numeroFactura = 00000000
      oc.fechaCreacion = new Date()
      oc.usuarioCreacion = 'admin'
      oc.direccionCliente = "TOLUCA, EDO DE MEX"
      oc.nombreCliente = "OFICINAS SUMITEL"
      oc.fechaModificacion = new Date()
      oc.usuarioModificacion = 'admin'
      oc.version = 1
      oc.save()

      NotaCompleta nc = new NotaCompleta()
      nc.setNombreCliente("Admin")
      nc.setNumeroRemision(23530)
      nc.setNombreEquipo("Vacio")
      nc.setDireccionCliente("Mexico")
      nc.setImei("0000")
      nc.setSimSerie("0000")
      nc.setPrecio(0)
      nc.setPrecioPublico(0)
      nc.setTelefono(0)
      nc.setTotalTexto("CERO")
      nc.setFechaCreacion(new Date())
      nc.setUsuarioCreacion("admin")
      nc.save(flush: true)*/

      /*Cliente c = new Cliente()
      c.nombre = 'ANA MARIA FRANGI'
      c.ciudad = 'Toluca'
      c.estado = 'Estado de México'
      c.fechaCreacion = new Date()
      c.usuarioCreacion = 'admin'
      c.save()

      Cliente c2 = new Cliente()
      c2.nombre = 'JOSE ANTONIO MARTI'
      c2.ciudad = 'CDMX'
      c2.estado = 'México'
      c2.fechaCreacion = new Date()
      c2.usuarioCreacion = 'admin'
      c2.save()*/

      //533039316

        /*tuplas.each { obj ->
        Inventario inv = new Inventario()
        inv.articulo = obj.articulo
        inv.precioSub = obj.preciosub
        inv.precioPublico = obj.preciopub
        inv.precioUnitario = obj.preciounitario
        inv.totalArticulos = obj.totalarticulos
        inv.costoSub = obj.costosub
        inv.costoPublico = obj.costopub
        inv.costoUnitario = obj.costounitario
        inv.usuarioCreacion = 'admin'
        inv.fechaCreacion = new Date()
        inv.save()
      }*/


    }

    def destroy = {
    }
}
