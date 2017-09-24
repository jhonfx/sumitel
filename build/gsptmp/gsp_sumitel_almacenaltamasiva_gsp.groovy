import sumitel.Almacen
import sumitel.Proveedor
import sumitel.Inventario
import grails.plugins.metadata.GrailsPlugin
import org.grails.gsp.compiler.transform.LineNumber
import org.grails.gsp.GroovyPage
import org.grails.web.taglib.*
import org.grails.taglib.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_sumitel_almacenaltamasiva_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/almacen/altamasiva.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
printHtmlPart(0)
printHtmlPart(1)
createTagBody(1, {->
printHtmlPart(2)
invokeTag('captureMeta','sitemesh',6,['gsp_sm_xmlClosingForEmptyTag':("/"),'name':("layout"),'content':("main")],-1)
printHtmlPart(2)
invokeTag('stylesheet','asset',7,['src':("application.css")],-1)
printHtmlPart(2)
invokeTag('set','g',8,['var':("entityName"),'value':(message(code: 'articulo.label', default: 'Articulo'))],-1)
printHtmlPart(3)
expressionOut.print(resource(dir: 'javascripts', file: 'underscore.js'))
printHtmlPart(4)
expressionOut.print(resource(dir: 'javascripts/utils', file: 'sumitel_utils.js'))
printHtmlPart(4)
expressionOut.print(resource(dir: 'javascripts', file: 'numeral.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'css', file: 'jsgrid.min.css'))
printHtmlPart(6)
expressionOut.print(resource(dir: 'css', file: 'jsgrid-theme.min.css'))
printHtmlPart(7)
expressionOut.print(resource(dir: 'javascripts', file: 'validate.js'))
printHtmlPart(8)
expressionOut.print(resource(dir: 'css', file: 'bttn.min.css'))
printHtmlPart(9)
createTagBody(2, {->
createClosureForHtmlPart(10, 3)
invokeTag('captureTitle','sitemesh',20,[:],3)
})
invokeTag('wrapTitleTag','sitemesh',20,[:],2)
printHtmlPart(11)
expressionOut.print(resource(dir: 'fonts', file: 'DK_High_Tea.otf'))
printHtmlPart(12)
expressionOut.print(createLink(controller:"inventario", action:"infoProducto"))
printHtmlPart(13)
expressionOut.print(createLink(controller:'almacen', action:'saveData'))
printHtmlPart(14)
expressionOut.print(createLink(controller: 'inventario', action: 'listarArticulos'))
printHtmlPart(15)
})
invokeTag('captureHead','sitemesh',373,[:],1)
printHtmlPart(0)
createTagBody(1, {->
printHtmlPart(16)
for( inventarioList in (Inventario.findAllByActivo(true)) ) {
printHtmlPart(17)
expressionOut.print(inventarioList.id)
printHtmlPart(18)
expressionOut.print(inventarioList.articulo)
printHtmlPart(19)
}
printHtmlPart(20)
invokeTag('select','g',418,['name':("proveedorId"),'id':("proveedorId"),'class':("form-control col-md-4"),'from':(Proveedor.findAll()),'optionKey':("id"),'optionValue':("nombreProveedor"),'noSelection':(['':'Seleccione...'])],-1)
printHtmlPart(21)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.core.js'))
printHtmlPart(22)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.load-indicator.js'))
printHtmlPart(22)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.load-strategies.js'))
printHtmlPart(22)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.sort-strategies.js'))
printHtmlPart(22)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.field.js'))
printHtmlPart(23)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.text.js'))
printHtmlPart(22)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.number.js'))
printHtmlPart(22)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.select.js'))
printHtmlPart(22)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.checkbox.js'))
printHtmlPart(22)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.control.js'))
printHtmlPart(24)
})
invokeTag('captureBody','sitemesh',463,[:],1)
printHtmlPart(25)
}
public static final Map JSP_TAGS = new HashMap()
protected void init() {
	this.jspTags = JSP_TAGS
}
public static final String CONTENT_TYPE = 'text/html;charset=UTF-8'
public static final long LAST_MODIFIED = 1496742923000L
public static final String EXPRESSION_CODEC = 'html'
public static final String STATIC_CODEC = 'none'
public static final String OUT_CODEC = 'none'
public static final String TAGLIB_CODEC = 'none'
}
