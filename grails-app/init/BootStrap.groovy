import sumitel.Menu

class BootStrap {

    def init = { servletContext ->

      /*Proveedor prov = new Proveedor()
      prov.nombreProveedor = 'TELCEL'
      prov.estatus = 1
      prov.usuarioCreacion = 'admin'
      prov.fechaCreacion = new Date()
      prov.save()*/


      def menuList = ['Compras', 'Clientes', 'Usuarios', 'Almacen', 'Inventario', 'Orden Compra', 'Notas Devolucion']
      menuList.each { obj -> 
        Menu menu = new Menu()
        menu.descripcionMenu = obj
        menu.save() 
      }

      /*Usuario u = new Usuario()
      u.nombre = 'Juan'
      u.apellido = 'Purata'
      u.login = 'admin'
      u.password = 'admin'
      u.usuarioCreacion = 'admin'
      u.fechaCreacion = new Date()
      u.save()

      OrdenCompra oc = new OrdenCompra()
      oc.id = 900
      oc.numeroOrden = 23460
      oc.numeroFactura = 00000000
      oc.fechaCreacion = new Date()
      oc.usuarioCreacion = 'admin'
      oc.fechaModificacion = new Date()
      oc.usuarioModificacion = 'admin'
      oc.save()

      Cliente c = new Cliente()
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
